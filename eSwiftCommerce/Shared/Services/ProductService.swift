//
//  ProductService.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts() async throws -> [Product]
    func fetchCart(userId: Int) async throws -> Cart
    func addToCart(userId: Int, productId: Int, quantity: Int) async throws -> Cart
    func deleteCartItem(cartId: Int, productId: Int) async throws
}

struct CartRequest: Codable {
    let userId: Int
    let date: String
    let products: [CartProduct]
}

class ProductService: ProductServiceProtocol {
    static let shared = ProductService()
    private let baseURL = "https://fakestoreapi.com"

    func fetchProducts() async throws -> [Product] {
        let url = URL(string: "\(baseURL)/products")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Product].self, from: data)
    }

    func fetchCart(userId: Int) async throws -> Cart {
        let url = URL(string: "\(baseURL)/carts/user/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let carts = try JSONDecoder().decode([Cart].self, from: data)
        guard let cart = carts.first else {
            throw NSError(
                domain: "Product Service",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "No cart found"]
            )
        }
        return cart
    }

    func addToCart(userId: Int, productId: Int, quantity: Int) async throws -> Cart {
        let url = URL(string: "\(baseURL)/carts")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = CartRequest(
            userId: userId,
            date: ISO8601DateFormatter().string(from: Date()),
            products: [CartProduct(productId: productId, quantity: quantity)]
        )
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Cart.self, from: data)
    }

    func deleteCartItem(cartId: Int, productId: Int) async throws {
        let url = URL(string: "\(baseURL)/carts/\(cartId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let _ = try await URLSession.shared.data(for: request)
    }
}

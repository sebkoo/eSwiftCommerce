//
//  APIService.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/8/25.
//

import Foundation

protocol APIServiceProtocol {
    func fetchProducts() async throws -> [Product]
}

class APIService: APIServiceProtocol {
    static let shared = APIService()
    private let baseURL = "https://fakestoreapi.com"

    func fetchProducts() async throws -> [Product] {
        let url = URL(string: "\(baseURL)/products")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Product].self, from: data)
    }
}

extension APIService {
    func fetchCart(for userId: Int) async throws -> Cart? {
        let url = URL(string: "\(baseURL)/carts/user/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let carts = try JSONDecoder().decode([Cart].self, from: data)
        return carts.last   // Use the most recent cart
    }

    func createCart(userId: Int, products: [CartProduct]) async throws -> Cart {
        let url = URL(string: "\(baseURL)/carts")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = CartRequest(
            userId: userId,
            date: ISO8601DateFormatter().string(from: Date()),
            products: products
        )
        request.httpBody = try JSONEncoder().encode(body)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Cart.self, from: data)
    }

    func updateCart(cartId: Int, products: [CartProduct]) async throws -> Cart {
        let url = URL(string: "\(baseURL)/carts/\(cartId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["products": products]
        request.httpBody = try JSONEncoder().encode(body)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Cart.self, from: data)
    }

    func fetchProduct(by id: Int) async throws -> Product {
        let url = URL(string: "\(baseURL)/products/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Product.self, from: data)
    }
}

struct CartRequest: Codable {
    let userId: Int
    let date: String
    let products: [CartProduct]
}

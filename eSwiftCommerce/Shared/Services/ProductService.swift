//
//  ProductService.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts() async throws -> [Product]
}

class ProductService: ProductServiceProtocol {
    static let shared = ProductService()
    private let baseURL = "https://fakestoreapi.com"

    func fetchProducts() async throws -> [Product] {
        let url = URL(string: "\(baseURL)/products")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Product].self, from: data)
    }
}

class MockProductService: ProductServiceProtocol {
    var fetchProductsResult: Result<[Product], Error>?

    func fetchProducts() async throws -> [Product] {
        switch fetchProductsResult {
        case .success(let products):
            return products
        case .failure(let error):
            throw error
        case nil:
            fatalError("fetchProductsResult not set")
        }
    }
}

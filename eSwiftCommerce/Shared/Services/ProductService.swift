//
//  ProductService.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import Foundation

class ProductService {
    static let shared = ProductService()
    private var products: [Int: Product] = [:]
    private let apiService = APIService.shared

    func getProduct(by id: Int) async throws -> Product {
        if let product = products[id] {
            return product
        } else {
            let product = try await apiService.fetchProduct(by: id)
            products[id] = product
            return product
        }
    }

    func fetchAllProducts() async throws -> [Product] {
        let products = try await apiService.fetchProducts()
        self.products = Dictionary(uniqueKeysWithValues: products.map { ($0.id, $0) })
        return products
    }
}

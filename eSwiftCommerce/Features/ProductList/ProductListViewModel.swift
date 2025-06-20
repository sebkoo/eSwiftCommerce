//
//  ProductListViewModel.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import Foundation

@MainActor
class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?

    private let productService: ProductService

    init(productService: ProductService = .shared) {
        self.productService = productService
    }

    func loadProducts() async {
        isLoading = true
        do {
            products = try await productService.fetchAllProducts()
        } catch {
            self.error = error
        }
        isLoading = false
    }
}

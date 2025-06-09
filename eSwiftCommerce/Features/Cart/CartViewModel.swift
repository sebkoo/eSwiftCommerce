//
//  CartViewModel.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/8/25.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    @Published var cart: Cart?
    @Published var cartProducts: [CartProduct] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?

    private let apiService = APIService.shared
    private let productService = ProductService.shared
    private let authService = AuthService.shared

    func loadCart() async {
        guard let userId = authService.getUserId(), userId != 0 else { return }
        isLoading = true
        do {
            if let cart = try await apiService.fetchCart(for: userId) {
                self.cart = cart
//                await
            }
        }
    }

    private func fetchCartItems() async {
        guard let cart = cart else { return }
        do {
            cartProducts = try await withThrowingTaskGroup(of: CartProduct.self) { group in
                for cartProduct in cartProducts {
                    group.addTask {
                        let product = try await self.productService.getProduct(by: cartProduct.productId)
                        return CartProduct(productId: , quantity: <#T##Int#>)
                    }
                }
            }
        }
    }
}

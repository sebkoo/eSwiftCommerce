//
//  ProductDetailViewModel.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    @Published var product: Product

    init(product: Product) {
        self.product = product
    }

    var formattedPrice: String {
        String(format: "%.2f", product.price)
    }
}

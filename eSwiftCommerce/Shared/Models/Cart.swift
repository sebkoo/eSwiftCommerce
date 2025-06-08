//
//  Cart.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import Foundation

struct Cart: Codable {
    let id: Int?
    let userId: Int
    let date: String
    let products: [CartProduct]
}

struct CartProduct: Codable {
    let productId: Int
    let quantity: Int
}

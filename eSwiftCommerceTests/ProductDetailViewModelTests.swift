//
//  ProductDetailViewModelTests.swift
//  eSwiftCommerceTests
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import XCTest
@testable import eSwiftCommerce

final class ProductDetailViewModelTests: XCTestCase {
    func test_productDetailViewModel_init() {
        let product = Product(id: 1, title: "Test", price: 10.0, description: "Desc", category: "Cat", image: "test.jpg")
        let viewModel = ProductDetailViewModel(product: product)

        XCTAssertEqual(viewModel.product.id, product.id)
        XCTAssertEqual(viewModel.product.title, product.title)
    }

}

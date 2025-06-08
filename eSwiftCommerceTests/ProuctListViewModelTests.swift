//
//  eSwiftCommerceTests.swift
//  eSwiftCommerceTests
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import XCTest
@testable import eSwiftCommerce

@MainActor
final class ProuctListViewModelTests: XCTestCase {
    func test_loadProduct_success() async {
        let mockService = MockProductService()
        let products = [Product(id: 1, title: "Test Product", price: 10.0, description: "", category: "", image: "")]
        mockService.fetchProductsResult = .success(products)

        let viewModel = ProductListViewModel(productService: mockService)

        await viewModel.loadProducts()

        XCTAssertEqual(viewModel.products, products)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }

    func test_loadProducts_failure() async {
        let mockService = MockProductService()
        let error = NSError(domain: "Test", code: 1)
        mockService.fetchProductsResult = .failure(error)

        let viewModel = ProductListViewModel(productService: mockService)

        await viewModel.loadProducts()

        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.error as? NSError, error)
    }
}

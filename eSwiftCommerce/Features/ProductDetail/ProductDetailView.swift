//
//  ProductDetailView.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject private var viewModel: ProductDetailViewModel

    init(product: Product) {
        _viewModel = .init(wrappedValue: .init(product: product))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: viewModel.product.image)) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                Text(viewModel.product.title)
                    .font(.title)
                    .fontWeight(.bold)
                Text("$\(viewModel.product.price, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Category: \(viewModel.product.category)")
                    .font(.title2)
                    .foregroundColor(.green)
                Text(viewModel.product.description)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(viewModel.product.title)
    }
}

#Preview {
    ProductDetailView(product: .init(id: 1,
                                     title: "Test",
                                     price: 100,
                                     description: "Test",
                                     category: "Test",
                                     image: "test")
    )
}

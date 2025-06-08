//
//  ProductListView.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(viewModel.products) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductCard(product: product)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Products")
            .task {
                await viewModel.loadProducts()
            }
        }
    }
}

#Preview {
    ProductListView()
}

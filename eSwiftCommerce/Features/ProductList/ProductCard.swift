//
//  ProductCard.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import SwiftUI

struct ProductCard: View {
    let product: Product

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 100)
            Text(product.title)
                .font(.headline)
                .lineLimit(2)
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    ProductCard(product: .init(id: 1,
                               title: "Test",
                               price: 100,
                               description: "Test",
                               category: "Test",
                               image: "Test"))
}

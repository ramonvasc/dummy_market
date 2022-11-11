//
//  ProductView.swift
//  market
//
//  Created by Ramon Vasconcelos on 11.11.2022.
//

import SwiftUI
import NukeUI

struct ProductView: View {
    private let product: Product
    private let onTap: (_ product: Product, _ amount: String) -> Void
    
    @State private var showingAlert = false
    @State private var amountOfProductsToAdd: String = ""
    
    init(product: Product, onTap: @escaping (_ product: Product, _ amount: String) -> Void) {
        self.product = product
        self.onTap = onTap
    }
    
    var body: some View {
        HStack {
            LazyImage(url: URL(string: product.images.first ?? ""), resizingMode: .aspectFit)
                .accessibilityLabel("Product image")
                .accessibilityAddTraits([.isImage])
                .flipsForRightToLeftLayoutDirection(true)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            VStack(alignment: .leading, spacing: 16) {
                Text(product.title)
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
                    .accessibilityLabel("Product title")
                    .accessibilityAddTraits([.isStaticText])
                Text(product.description)
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                    .accessibilityLabel("Product description")
                    .accessibilityAddTraits([.isStaticText])
                Text("Price: \(product.price, specifier: "%lld")")
                    .accessibilityLabel("Product price")
                    .accessibilityAddTraits([.isStaticText])
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                Text("Brand: \(product.brand)")
                    .accessibilityLabel("Product brand")
                    .accessibilityAddTraits([.isStaticText])
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                Text("In Stock: \(product.stock, specifier: "%lld")")
                    .accessibilityLabel("In stock Products")
                    .accessibilityAddTraits([.isStaticText])
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                Button("Add to cart") { showingAlert = true }
                    .accessibilityLabel("Add to cart button")
                    .accessibilityHint("Adds product to cart")
                    .accessibilityAddTraits([.isButton, .allowsDirectInteraction])
                    .contentShape(Rectangle())
                    .foregroundColor(.accentColor)
                    .buttonStyle(BorderedButtonStyle())
                    .alert("Units of product", isPresented: $showingAlert, actions: {
                        TextField("Amount", text: $amountOfProductsToAdd).accessibilityLabel("Amount of products desired")
                            .accessibilityHint("Enter amount of products")
                            .accessibilityAddTraits([.allowsDirectInteraction])
                            .keyboardType(.numberPad)
                        Button("Ok", action: {
                            onTap(product, $amountOfProductsToAdd.wrappedValue)
                            $amountOfProductsToAdd.wrappedValue = "0"
                        })
                        .accessibilityLabel("Ok button")
                        .accessibilityHint("Closes alert")
                        .accessibilityAddTraits([.isButton, .allowsDirectInteraction])
                    }, message: {
                        Text("Please enter how many products you want.")
                            .accessibilityLabel("Please enter how many products you want.")
                            .accessibilityAddTraits([.isStaticText])
                    })
            }
        }
    }
}

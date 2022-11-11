//
//  ContentView.swift
//  market
//
//  Created by Ramon Vasconcelos on 11.11.2022.
//

import SwiftUI

struct ProductsListView: View {
    @ObservedObject private(set) var viewModel = ProductsViewModel()
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            List(viewModel.products.products, id: \.self) {
                ProductView(product: $0) { product, amount in
                    addProduct(product, amount)
                }
            }.navigationBarTitle("Products").accessibilityLabel("Products")
                .accessibilityAddTraits([.isHeader])
                .toolbar {
                    Button("Cart Items: \(viewModel.productsOnCart.count, specifier: "%lld")") {
                        print("Go to Cart")
                    }
                    .accessibilityLabel("Go to cart button")
                    .accessibilityValue("Cart Items: \(viewModel.productsOnCart.count, specifier: "%lld")")
                    .accessibilityHint("Opens cart view")
                    .accessibilityAddTraits([.isButton, .allowsDirectInteraction])
                }
                .onAppear {
                    viewModel.fetchProducts()
                }
                .alert("Not enough products are available", isPresented: $showingAlert) {
                    Button("Ok") { }
                        .accessibilityLabel("Ok button")
                        .accessibilityHint("Closes alert")
                        .accessibilityAddTraits([.isButton, .allowsDirectInteraction])
                }
        }
    }
    
    func addProduct(_ product: Product, _ amount: String) {
        if !viewModel.addProductToCart(product, amount: amount) {
            showingAlert = true
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView().environment(\.locale, .init(identifier: "en"))
            .previewDisplayName("English")
        
        ProductsListView().environment(\.locale, .init(identifier: "pt"))
            .previewDisplayName("Portuguese")
        
        ProductsListView().environment(\.layoutDirection, .leftToRight)
            .previewDisplayName("Left to Right")
        
        ProductsListView().environment(\.layoutDirection, .rightToLeft)
            .previewDisplayName("Right To Left")
    }
}

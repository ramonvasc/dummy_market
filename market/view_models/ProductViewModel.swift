//
//  ProductViewModel.swift
//  market
//
//  Created by Ramon Vasconcelos on 11.11.2022.
//

import Combine
import SwiftUI

class ProductsViewModel: ObservableObject {    
    @Published var products: Products
    @Published var productsOnCart: [Product: Int]

    private let productsService: ProductsService
    
    init(products: Products = Products(products: [], total: 0, skip: 0, limit: 0), productsOnCart: [Product : Int] = [:], productsService: ProductsService = ProductsService()) {
        self.products = products
        self.productsOnCart = productsOnCart
        self.productsService = productsService
    }
    
    func fetchProducts() {
        productsService.fetchProducts(viewModel: self)
    }
    
    func addProductToCart(_ product: Product, amount: String) -> Bool {
        let latinNumber = toLatinNumber(number: amount)
        if latinNumber <= product.stock, latinNumber > 0 {
            productsOnCart[product] = latinNumber
            return true
        }
        return false
    }
    
    // Formats numbers from non latin alphabets to latin.
    private func toLatinNumber(number: String) -> Int {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
        guard let final = formatter.number(from: number) else {
            return 0
        }
        return Int(truncating: final)
    }
}


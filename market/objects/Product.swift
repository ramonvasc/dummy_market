//
//  Product.swift
//  market
//
//  Created by Ramon Vasconcelos on 11.11.2022.
//

import Foundation

struct Product: Decodable, Hashable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let images: [String]
}

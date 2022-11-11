//
//  Products.swift
//  market
//
//  Created by Ramon Vasconcelos on 11.11.2022.
//

import Foundation

struct Products: Decodable, Hashable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

//
//  ProductsService.swift
//  market
//
//  Created by Ramon Vasconcelos on 11.11.2022.
//

import Combine
import Foundation

class ProductsService {
    private let url = "https://dummyjson.com/products"
    private var task: AnyCancellable?
    
    func fetchProducts(viewModel: ProductsViewModel) {
        task = URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .map { return $0.data }
            .decode(type: Products.self, decoder: JSONDecoder())
            .replaceError(with: Products(products: [], total: 0, skip: 0, limit: 0))
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \ProductsViewModel.products, on: viewModel)
    }
}

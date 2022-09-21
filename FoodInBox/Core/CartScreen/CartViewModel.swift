//
//  CartViewModel.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 21.09.2022.
//

import Foundation

class CartViewModel {
    
    var products: Observable<[ProductData]> = Observable([])
    
    func getProducts() {
        ProductStore.retrieveProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.products.value = products
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  CartViewModel.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 21.09.2022.
//

import Foundation

class CartViewModel {
    
    var products: Observable<[ProductData]> = Observable([])
    
    var totalPrice: Double {
        products.value.reduce(0) { partialResult, product in
            if product.campaignPrice != nil {
                return partialResult + (product.campaignPrice ?? 0)
            }
            
            return partialResult + (product.price ?? 0)
        }
    }
    
    func getProducts() {
        ProductStore.retrieveProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.products.value = products
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

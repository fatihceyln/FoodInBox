//
//  ProductsViewModel.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import Foundation

class ProductsViewModel {
    
    var products: Observable<[ProductData]> = Observable([])
    
    private let service: ProductService
    
    init(service: ProductService) {
        self.service = service
    }
    
    func getProducts() {
        service.downloadProducts { [weak self] returnedProducts in
            guard let self = self else { return }
            
            self.products.value = returnedProducts
        }
    }
}

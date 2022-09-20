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
    
    func getProducts(urlString: String) {
        service.downloadProducts(urlString: urlString) { [weak self] returnedProducts in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                var tempProducts: [ProductData] = []
                for product in returnedProducts {
                    if !tempProducts.contains(where: {$0.title == product.title}) {
                        tempProducts.append(product)
                    }
                }
                self.products.value = tempProducts
            }
        }
    }
}

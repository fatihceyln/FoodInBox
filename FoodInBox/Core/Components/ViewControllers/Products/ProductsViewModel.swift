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
                tempProducts.sort { p1, p2 in
                    if p1.campaignPrice != nil && p2.campaignPrice == nil {
                        return (p1.campaignPrice ?? 0) < (p2.price ?? 0)
                    } else if p1.campaignPrice == nil && p2.campaignPrice != nil {
                        return (p1.price ?? 0) < (p2.campaignPrice ?? 0)
                    } else if p1.campaignPrice != nil && p2.campaignPrice != nil {
                        return (p1.campaignPrice ?? 0) < (p2.campaignPrice ?? 0)
                    }
                    
                    return (p1.price ?? 0) < (p2.price ?? 0)
                }
                self.products.value = tempProducts
            }
        }
    }
}

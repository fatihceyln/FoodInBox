//
//  ProductStore.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 21.09.2022.
//

import Foundation

enum ProductStore {
    static private let defaults = UserDefaults.standard
    
    static let key = "content"
    
    static func update(product: ProductData) {
        retrieveProducts { result in
            switch result {
            case .success(var products):
                if products.contains(where: {$0.id == product.id}) {
                    products.removeAll(where: {$0.id == product.id})
                } else {
                    products.append(product)
                }
                
                saveProducts(products: products)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func retrieveProducts(completion: @escaping (Result<[ProductData], FCError>) -> ()) {
        guard let productsData = defaults.object(forKey: key) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let products = try JSONDecoder().decode([ProductData].self, from: productsData)
            
            completion(.success(products))
        } catch {
            completion(.failure(.unableToDecode))
        }
    }
    
    private static func saveProducts(products: [ProductData]) {
        do {
            let encodedProducts = try JSONEncoder().encode(products)
            defaults.set(encodedProducts, forKey: key)
        } catch {
            print(error)
        }
    }
    
    static func removeAll() {
        retrieveProducts { result in
            switch result {
            case .success(var products):
                products.removeAll()
                
                saveProducts(products: products)
            case .failure(let error):
                print(error)
            }
        }
    }
}

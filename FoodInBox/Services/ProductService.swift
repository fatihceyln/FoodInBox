//
//  ProductService.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import Foundation

class ProductService {
    
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func downloadProducts(completion: @escaping ([ProductData]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        NetworkingManager.shared.download(url: url) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    private func handleWithData(_ data: Data) -> [ProductData] {
        do {
            let category = try JSONDecoder().decode(Product.self, from: data)
            guard let categoryData = category.data else { return [] }
            
            return categoryData
        } catch {
            print(error)
            return []
        }
    }
    
    private func handleWithError(_ error: Error) {
        print("Error: \(error)")
    }
}

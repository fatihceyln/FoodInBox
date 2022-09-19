//
//  HomeViewModel.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import Foundation

class HomeViewModel {
    
    var categories: Observable<[CategoryData]> = Observable([])
    var selectedCategory: Observable<CategoryData?> = Observable(nil)
    
    private let service: CategoryService
    
    init(service: CategoryService) {
        self.service = service
    }
    
    func getCategories() {
        service.downloadCategories { [weak self] returnedCategories in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.categories.value = returnedCategories
                self.selectedCategory.value = returnedCategories.first
            }
        }
    }
}

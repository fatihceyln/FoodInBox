//
//  UIHelper.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

enum UIHelper {
    static func createCategoryFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = UIScreen.main.bounds.width / 2.5
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.1)
        
        return layout
    }
    
    static func createProductFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = UIScreen.main.bounds.width / 3
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.4)
        
        return layout
    }
    
    static var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}

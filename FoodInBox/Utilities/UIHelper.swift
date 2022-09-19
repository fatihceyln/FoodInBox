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
}

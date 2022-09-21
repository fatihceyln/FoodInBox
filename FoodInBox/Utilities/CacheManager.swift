//
//  CacheManager.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

class CacheManager {
    static let shared = CacheManager()
    private init() {}
    
    let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 60
        cache.totalCostLimit = 1024 * 1024 * 40
        return cache
    }()
}

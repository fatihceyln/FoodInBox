//
//  APIUrls.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import Foundation

enum APIUrls {
    private static let baseURL = "https://api.shopiroller.com/v2.0"
    
    static let categories = "\(baseURL)/categories"
    
    static func products(categoryId: String) -> String {
        "\(baseURL)/advanced-filtered?categoryId=\(categoryId)"
    }
    
    static func product(productId: String) -> String {
        "\(baseURL)/products/\(productId)"
    }
}

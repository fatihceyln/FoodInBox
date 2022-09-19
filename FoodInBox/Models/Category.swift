//
//  Category.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import Foundation

struct Category: Codable {
    let data: [CategoryData]?
}

struct CategoryData: Codable, Equatable {
    let categoryID, name: String?
    let icon: String?
    let totalProducts: Int?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case name, icon, totalProducts
    }
}

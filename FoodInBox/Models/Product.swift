//
//  Product.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import Foundation

struct Product: Codable {
    let data: [ProductData]?
}

struct ProductData: Codable {    
    let id: String?
    let title: String?
    let images: [Icon]?
    let description: String?
    let price: Double?
    let campaignPrice, shippingPrice: Double?
    let createDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title, images
        case description
        case price, campaignPrice, shippingPrice, createDate
    }
    
    var loremDescription: String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla lectus velit, sodales nec pretium elementum, porttitor id orci."
    }
}

struct Icon: Codable {
    let use, dontUse: String?
    
    enum CodingKeys: String, CodingKey {
        case use = "n"
        case dontUse = "t"
    }
}

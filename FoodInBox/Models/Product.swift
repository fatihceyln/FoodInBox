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
    let id, appID: String?
    let category: CategoryData?
    let categoryID: String?
    let title: String?
    let images: [Icon]?
    let description: String?
    let stock: Int?
    let stockCode: String?
    let price: Int?
    let campaignPrice, shippingPrice: Int?
    let createDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case appID = "appId"
        case category
        case categoryID = "categoryId"
        case title, images
        case description
        case stock, stockCode, price, campaignPrice, shippingPrice, createDate
    }
}

struct Icon: Codable {
    let t, n: String?
}

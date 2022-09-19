//
//  FCError.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import Foundation

enum FCError: String, Error {
    case invalidData = "The data received from the service was invalid."
    case invalidResponse = "The response got back from the service was invalid."
    case unableToDecode = "Unable to decode from data."
    case unableToComplete = "Unable to complete the request."
}

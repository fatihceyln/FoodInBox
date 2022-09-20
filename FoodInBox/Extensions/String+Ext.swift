//
//  String+Ext.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 20.09.2022.
//

import Foundation

extension String {
    func asTRYCurrency() -> Self {
        var string = self
        string.append(" ₺")
        
        return string
    }
}

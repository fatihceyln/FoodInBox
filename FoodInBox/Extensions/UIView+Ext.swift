//
//  UIView+Ext.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//


import UIKit

extension UIView {
    func pinToEdges(of superView: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}

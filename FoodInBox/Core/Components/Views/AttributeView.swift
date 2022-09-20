//
//  AttributeView.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 20.09.2022.
//

import UIKit

class AttributeView: UIView {
    
    private var headerLabel: UILabel!
    private var bodyLabel: UILabel!
    
    init(headerText: String, bodyText: String) {
        super.init(frame: .zero)
        
        configureHeaderLabel(headerText: headerText)
        configureBodyLabel(bodyText: bodyText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeaderLabel(headerText: String) {
        headerLabel = UILabel(frame: .zero)
        addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = headerText
        headerLabel.font = .systemFont(ofSize: 16)
        headerLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func configureBodyLabel(bodyText: String) {
        bodyLabel = UILabel(frame: .zero)
        addSubview(bodyLabel)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.text = bodyText
        bodyLabel.font = .boldSystemFont(ofSize: 20)
        bodyLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

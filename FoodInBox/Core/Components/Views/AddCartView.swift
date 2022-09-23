//
//  AddCartView.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 21.09.2022.
//

import UIKit

protocol AddCartViewDelegate: AnyObject {
    func addCartButtonAction()
}

class AddCartView: UIView {
    
    private var beforeCampaingPriceLabel: UILabel!
    private var priceLabel: UILabel!
    private var addToCartButton: UIButton!
    
    private let product: ProductData!
    
    private weak var delegate: AddCartViewDelegate!

    init(product: ProductData, delegate: AddCartViewDelegate) {
        self.product = product
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .systemGray6.withAlphaComponent(0.6)
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.delegate = delegate
        
        configurePriceLabel()
        configureAddToCartButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeButtonTitle() {
        addToCartButton.setTitle("Remove from Cart", for: .normal)
    }
    
    private func configurePriceLabel() {
        priceLabel = UILabel(frame: .zero)
        addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.font = .boldSystemFont(ofSize: 32)
        priceLabel.textColor = .systemOrange
        
        if let campaingPrice = product.campaignPrice {
            priceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: campaingPrice))?.asTRYCurrency()
            priceLabel.textColor = .systemGreen
            
            configureBeforeCampaingPriceLabel()
        } else {
            priceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: product.price ?? 0))?.asTRYCurrency()
        }
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureAddToCartButton() {
        addToCartButton = UIButton(frame: .zero)
        addSubview(addToCartButton)
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        addToCartButton.backgroundColor = .systemOrange
        
        addToCartButton.addTarget(self, action: #selector(addCartButtonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            addToCartButton.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    private func configureBeforeCampaingPriceLabel() {
        beforeCampaingPriceLabel = UILabel(frame: .zero)
        addSubview(beforeCampaingPriceLabel)
        
        beforeCampaingPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        beforeCampaingPriceLabel.textColor = .systemOrange
        beforeCampaingPriceLabel.font = .systemFont(ofSize: 18)
        beforeCampaingPriceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: product.price ?? 0))?.asTRYCurrency()
        beforeCampaingPriceLabel.strikeThrough(true)
        
        NSLayoutConstraint.activate([
            beforeCampaingPriceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            beforeCampaingPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            beforeCampaingPriceLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor)
        ])
    }
    
    @objc private func addCartButtonAction() {
        delegate.addCartButtonAction()
    }
}

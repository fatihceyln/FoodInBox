//
//  CartConfirmView.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 23.09.2022.
//

import UIKit

protocol CartConfirmViewProtocol: AnyObject {
    func confirmButtonPressed()
}

class CartConfirmView: UIStackView {
    
    private var priceStackView: UIStackView!
    private var priceTitleLabel: UILabel!
    private var totalPriceLabel: UILabel!
    
    private var confirmButton: UIButton!
    
    private weak var delegate: CartConfirmViewProtocol!

    init(delegate: CartConfirmViewProtocol) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        
        configureView()
        
        configurePriceStackView()
        configurePriceTitleLabel()
        configureTotalPriceLabel()
        
        configureConfirmButton()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPrice(totalPrice: Double) {
        self.totalPriceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: totalPrice))?.asTRYCurrency()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .systemGray6
        
        axis = .horizontal
        spacing = 40
        distribution = .fill
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private func configurePriceStackView() {
        priceStackView = UIStackView(frame: .zero)
        addArrangedSubview(priceStackView)
        
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        priceStackView.axis = .vertical
        priceStackView.spacing = 5
        priceStackView.distribution = .fill
    }
    
    private func configurePriceTitleLabel() {
        priceTitleLabel = UILabel(frame: .zero)
        priceStackView.addArrangedSubview(priceTitleLabel)
        
        priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceTitleLabel.text = "Total"
        priceTitleLabel.textColor = .secondaryLabel
        priceTitleLabel.font = .systemFont(ofSize: 18)
    }
    
    private func configureTotalPriceLabel() {
        totalPriceLabel = UILabel(frame: .zero)
        priceStackView.addArrangedSubview(totalPriceLabel)
        
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        totalPriceLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func configureConfirmButton() {
        confirmButton = UIButton(frame: .zero)
        addArrangedSubview(confirmButton)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        confirmButton.layer.cornerRadius = 10
        confirmButton.backgroundColor = .systemOrange
        
        confirmButton.setTitle("Confirm the Cart", for: .normal)
        confirmButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
    }
    
    @objc private func confirmButtonPressed() {
        delegate.confirmButtonPressed()
    }
    
}

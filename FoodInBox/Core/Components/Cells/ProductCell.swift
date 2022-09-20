//
//  ProductCell.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 20.09.2022.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static let reuseID = "ProductCell"
    
    private var productImageView: FCImageView!
    private var titleLabel: UILabel!
    private var priceLabel: UILabel!
    private var campaingPriceLabel: UILabel!
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        backgroundColor = .systemGray6
        
        configureProductImageView()
        configureTitleLabel()
        configurePriceLabel()
        configureCampaingPriceLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.cancelDownloading()
        productImageView.image = nil
        
        titleLabel.text = nil
        
        priceLabel.strikeThrough(false)
        priceLabel.text = nil
        priceLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.textAlignment = .center
        
        campaingPriceLabel.text = nil
    }
    
    func set(_ product: ProductData) {
        titleLabel.text = product.title
        priceLabel.text = formatter.string(from: NSNumber(value: product.price ?? 0))
        priceLabel.text?.append(" ₺")
        productImageView.downloadImage(urlString: product.images?.first?.n ?? "", renderingMode: .alwaysOriginal)
        
        if let campaingPrice = product.campaignPrice {
            
            priceLabel.strikeThrough(true)
            priceLabel.font = .systemFont(ofSize: 16)
            priceLabel.textAlignment = .left
            
            campaingPriceLabel.alpha = 1
            campaingPriceLabel.text = formatter.string(from: NSNumber(value: campaingPrice))
            campaingPriceLabel.text?.append(" ₺")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureProductImageView() {
        productImageView = FCImageView(frame: .zero)
        addSubview(productImageView)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor)
        ])
    }
    
    private func configurePriceLabel() {
        priceLabel = UILabel(frame: .zero)
        addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.textAlignment = .center
        priceLabel.textColor = .orange
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor)
        ])
    }
    
    private func configureCampaingPriceLabel() {
        campaingPriceLabel = UILabel(frame: .zero)
        addSubview(campaingPriceLabel)
        
        campaingPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        campaingPriceLabel.font = .boldSystemFont(ofSize: 24)
        campaingPriceLabel.textAlignment = .right
        campaingPriceLabel.textColor = .systemGreen
        campaingPriceLabel.alpha = 0
        
        NSLayoutConstraint.activate([
            campaingPriceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            campaingPriceLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            campaingPriceLabel.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -10)
        ])
    }
}

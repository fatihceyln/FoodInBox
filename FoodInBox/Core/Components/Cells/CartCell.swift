//
//  CartCell.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 21.09.2022.
//

import UIKit

class CartCell: UITableViewCell {
    
    static let reuseID = "CartCell"
    
    private var productImageView: FCImageView!
    private var productTitleLabel: UILabel!
    private var productDescriptionLabel: UILabel!
    private var productPriceLabel: UILabel!
    private var productCampaingPriceLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureProductImageView()
        configureProductTitleLabel()
        configureProductDescriptionLabel()
        configureProductPriceLabel()
        configureProductCampaingLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.cancelDownloading()
        productImageView.image = nil
        
        productTitleLabel.text = nil
        
        productPriceLabel.strikeThrough(false)
        productPriceLabel.text = nil
        productPriceLabel.font = .boldSystemFont(ofSize: 20)
        
        productCampaingPriceLabel.text = nil
    }
    
    func set(_ product: ProductData) {
        guard let urlString = product.images?.first?.use else { return }
        productImageView.downloadImage(urlString: urlString, renderingMode: .alwaysOriginal)
        
        productTitleLabel.text = product.title
        productDescriptionLabel.text = product.loremDescription
        productPriceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: product.price ?? 0))?.asTRYCurrency()
        
        
        if let campaingPrice = product.campaignPrice {
            productCampaingPriceLabel.text = UIHelper.numberFormatter.string(from: NSNumber(value: campaingPrice))?.asTRYCurrency()
            productPriceLabel.strikeThrough(true)
            productPriceLabel.font = .boldSystemFont(ofSize: 16)
        }
    }
    
    private func configureProductImageView() {
        productImageView = FCImageView(frame: .zero)
        addSubview(productImageView)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        productImageView.backgroundColor = .red
    }
    
    private func configureProductTitleLabel() {
        productTitleLabel = UILabel(frame: .zero)
        addSubview(productTitleLabel)
        
        productTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        productTitleLabel.font = .boldSystemFont(ofSize: 20)
        
        NSLayoutConstraint.activate([
            productTitleLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            productTitleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            productTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func configureProductDescriptionLabel() {
        productDescriptionLabel = UILabel(frame: .zero)
        addSubview(productDescriptionLabel)
        
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        productDescriptionLabel.font = .systemFont(ofSize: 16)
        productDescriptionLabel.textColor = .secondaryLabel
        productDescriptionLabel.numberOfLines = 1
        
        NSLayoutConstraint.activate([
            productDescriptionLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 5),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func configureProductPriceLabel() {
        productPriceLabel = UILabel(frame: .zero)
        addSubview(productPriceLabel)
        
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        productPriceLabel.font = .boldSystemFont(ofSize: 20)
        productPriceLabel.textColor = .systemOrange
        
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 5),
            productPriceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            productPriceLabel.widthAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configureProductCampaingLabel() {
        productCampaingPriceLabel = UILabel(frame: .zero)
        addSubview(productCampaingPriceLabel)
        
        productCampaingPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        productCampaingPriceLabel.font = .boldSystemFont(ofSize: 20)
        productCampaingPriceLabel.textColor = .systemGreen
        
        NSLayoutConstraint.activate([
            productCampaingPriceLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 5),
            productCampaingPriceLabel.leadingAnchor.constraint(equalTo: productPriceLabel.trailingAnchor, constant: 5),
            productCampaingPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}

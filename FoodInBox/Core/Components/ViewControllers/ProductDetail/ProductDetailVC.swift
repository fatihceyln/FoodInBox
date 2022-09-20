//
//  ProductDetailVC.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 20.09.2022.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    
    private var productImageView: FCImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var attributeStackView: UIStackView!
    private var sizeAttribute: AttributeView!
    private var caloriesAttribute: AttributeView!
    private var cookingAttribute: AttributeView!
    
    private var cartContainerView: UIView!
    private var priceLabel: UILabel!
    private var addToCartButton: UIButton!
    
    private let product: ProductData!
    
    init(product: ProductData) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = .orange
        
        configureScrollView()
        configureStackView()
        
        configureProductImageView()
        configureTitleLabel()
        
        configureAttributeStackView()
        configureAttributes()
        
        configureDescriptionLabel()
        
        configureCartContainerView()
        configurePriceLabel()
        configureAddToCartButton()
    }
}

extension ProductDetailVC {
    private func configureScrollView() {
        scrollView = UIScrollView(frame: .zero)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.pinToEdges(of: view)
    }
    
    private func configureStackView() {
        stackView = UIStackView()
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 30, right: 10)
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        stackView.pinToEdges(of: scrollView)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func configureProductImageView() {
        productImageView = FCImageView(frame: .zero)
        stackView.addArrangedSubview(productImageView)

        guard let urlString = product.images?.first?.n else { return }
        productImageView.downloadImage(urlString: urlString, renderingMode: .alwaysOriginal)

        productImageView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        stackView.addArrangedSubview(titleLabel)
        
        titleLabel.text = product.title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 26)
    }
    
    private func configureAttributeStackView() {
        attributeStackView = UIStackView(frame: .zero)
        stackView.addArrangedSubview(attributeStackView)
        stackView.setCustomSpacing(40, after: titleLabel)
        
        attributeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        attributeStackView.axis = .horizontal
        attributeStackView.distribution = .fillEqually
        attributeStackView.spacing = 10
        
        attributeStackView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func configureAttributes() {
        sizeAttribute = AttributeView(headerText: "Size", bodyText: "Medium")
        attributeStackView.addArrangedSubview(sizeAttribute)
        
        caloriesAttribute = AttributeView(headerText: "Calories", bodyText: "150 Kcal")
        attributeStackView.addArrangedSubview(caloriesAttribute)
        
        cookingAttribute = AttributeView(headerText: "Cooking", bodyText: "10-15 min")
        attributeStackView.addArrangedSubview(cookingAttribute)
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel = UILabel(frame: .zero)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.setCustomSpacing(40, after: attributeStackView)
        
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.text = product.loremDescription
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
    }
    
    private func configureCartContainerView() {
        cartContainerView = UIView(frame: .zero)
        stackView.addArrangedSubview(cartContainerView)
        stackView.setCustomSpacing(40, after: descriptionLabel)
        
        cartContainerView.layer.cornerRadius = 10
        cartContainerView.backgroundColor = .systemGray6.withAlphaComponent(0.6)
        
        cartContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func configurePriceLabel() {
        priceLabel = UILabel(frame: .zero)
        cartContainerView.addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.font = .boldSystemFont(ofSize: 32)
        priceLabel.textColor = .orange
        
        if let campaingPrice = product.campaignPrice {
            priceLabel.text = formatter.string(from: NSNumber(value: campaingPrice))?.asTRYCurrency()
        } else {
            priceLabel.text = formatter.string(from: NSNumber(value: product.price ?? 0))?.asTRYCurrency()
        }
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: cartContainerView.leadingAnchor, constant: 20),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            priceLabel.centerYAnchor.constraint(equalTo: cartContainerView.centerYAnchor)
        ])
    }
    
    private func configureAddToCartButton() {
        addToCartButton = UIButton(frame: .zero)
        cartContainerView.addSubview(addToCartButton)
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        addToCartButton.tintColor = .orange
        addToCartButton.backgroundColor = .orange
        
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: cartContainerView.topAnchor, constant: 20),
            addToCartButton.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20),
            addToCartButton.trailingAnchor.constraint(equalTo: cartContainerView.trailingAnchor, constant: -20),
            addToCartButton.bottomAnchor.constraint(equalTo: cartContainerView.bottomAnchor, constant: -20)
        ])
    }
}

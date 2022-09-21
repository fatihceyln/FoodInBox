//
//  ProductDetailVC.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 20.09.2022.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    
    private var productImageView: FCImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var attributeStackView: UIStackView!
    private var sizeAttribute: AttributeView!
    private var caloriesAttribute: AttributeView!
    private var cookingAttribute: AttributeView!
    
    private var addCartView: AddCartView!
    
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
        
        configureVC()
        
        configureScrollView()
        configureStackView()
        
        configureProductImageView()
        configureTitleLabel()
        
        configureAttributeStackView()
        configureAttributes()
        
        configureDescriptionLabel()
        
        configureCartContainerView()
        
        checkIfIsInTheCart()
    }
}

extension ProductDetailVC {
    private func checkIfIsInTheCart() {
        ProductStore.retrieveProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                if products.contains(where: {$0 == self.product}) {
                    self.addCartView.changeButtonTitle()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ProductDetailVC {
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
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
}

extension ProductDetailVC {
    private func configureProductImageView() {
        productImageView = FCImageView(frame: .zero)
        stackView.addArrangedSubview(productImageView)

        guard let urlString = product.images?.first?.use else { return }
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
}

extension ProductDetailVC {
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
    
}

extension ProductDetailVC {
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
}

extension ProductDetailVC {
    private func configureCartContainerView() {
        addCartView = AddCartView(product: product, delegate: self)
        stackView.addArrangedSubview(addCartView)
        stackView.setCustomSpacing(40, after: descriptionLabel)
    }
}

extension ProductDetailVC: AddCartViewDelegate {
    func addCartButtonAction() {
        
        ProductStore.update(product: product)
        
        
        navigationController?.popViewController(animated: true)
    }
}

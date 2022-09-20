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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureProductImageView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.cancelDownloading()
        productImageView.image = nil
    }
    
    func set(_ product: ProductData) {
        productImageView.downloadImage(urlString: product.images?.first?.n ?? "", renderingMode: .alwaysOriginal)
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
}

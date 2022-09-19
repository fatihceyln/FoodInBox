//
//  CategoryCell.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
        
    static let reuseID = "CategoryCell"
    
    private var categoryImageView: FCImageView!
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        
        configureCategoryImageView()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        backgroundColor = .systemGray6
        
        titleLabel.text = nil
        categoryImageView.image = nil
        
        categoryImageView.cancelDownloading()
        categoryImageView.dataTask = nil
    }
    
    func set(_ categoryData: CategoryData) {
        titleLabel.text = categoryData.name ?? ""
        
        if let urlString = categoryData.icon {
            categoryImageView.downloadImage(urlString: urlString)
        }
    }
    
    private func configureCategoryImageView() {
        categoryImageView = FCImageView(frame: .zero)
        addSubview(categoryImageView)
        
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            categoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            categoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            categoryImageView.heightAnchor.constraint(equalTo: categoryImageView.widthAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 18)
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}

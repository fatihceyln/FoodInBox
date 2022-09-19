//
//  CategoryCell.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
        
    static let reuseID = "CategoryCell"
    
    private var categoryImageView: UIImageView!
    private var titleLabel: UILabel!
    
    private var dataTask: URLSessionDataTask?
    
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
        
        titleLabel.text = nil
        categoryImageView.image = nil
        
        dataTask?.cancel()
        dataTask = nil
    }
    
    func set(_ categoryData: CategoryData) {
        titleLabel.text = categoryData.name ?? ""
        
        guard let url = URL(string: categoryData.icon ?? "") else { return }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, _, _ in
            guard let self = self else { return }
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.categoryImageView.image = UIImage(data: data)?.withRenderingMode(.alwaysTemplate)
                self.categoryImageView.tintColor = .white
            }
        })
        
        dataTask?.resume()
    }
    
    private func configureCategoryImageView() {
        categoryImageView = UIImageView(frame: .zero)
        addSubview(categoryImageView)
        
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.layer.cornerRadius = 10
        categoryImageView.clipsToBounds = true
        
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

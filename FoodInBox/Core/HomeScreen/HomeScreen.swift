//
//  HomeScreen.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

class HomeScreen: UIViewController {
    
    private let viewModel: HomeViewModel
    
    private var categoriesCollectionView: UICollectionView!
    
    init(service: CategoryService) {
        viewModel = HomeViewModel(service: service)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureCategoriesCollectionView()
        
        addBinders()
        
        viewModel.getCategories()
    }
    
    private func addBinders() {
        viewModel.categories.bind { [weak self] _ in
            guard let self = self else { return }
            
            // Update UI
            
            self.categoriesCollectionView.reloadData()
            
        }
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCategoriesCollectionView() {
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureFlowLayout())
        view.addSubview(categoriesCollectionView)
        
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            categoriesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoriesCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])
    }
    
    private func configureFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = UIScreen.main.bounds.width / 2.5
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.1)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        return layout
    }
}

extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categories.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
        cell.set(viewModel.categories.value[indexPath.row])
        
        return cell
    }
}

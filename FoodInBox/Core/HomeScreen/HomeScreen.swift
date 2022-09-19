//
//  HomeScreen.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

class HomeScreen: UIViewController {
    
    private let viewModel: HomeViewModel
    
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    private var categoriesView: CategoriesView!
    
    init(service: CategoryService) {
        viewModel = HomeViewModel(service: service)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configureStackView()
        configureCategoriesView()
        
        addBinders()
        viewModel.getCategories()
    }
    
    private func addBinders() {
        viewModel.categories.bind { [weak self] _ in
            guard let _ = self else { return }
            
            // Update UI
            self?.categoriesView.collectionView.reloadData()
        }
        
        viewModel.selectedCategory.bind { [weak self] _ in
            guard let _ = self else { return }
            
        }
    }
    
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
        stackView.layoutMargins = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func configureCategoriesView() {
        categoriesView = CategoriesView(frame: .zero)
        stackView.addArrangedSubview(categoriesView)
        
        categoriesView.collectionView.delegate = self
        categoriesView.collectionView.dataSource = self
        categoriesView.setTitle("Categories")
    }
}

extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categories.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
        cell.set(viewModel.categories.value[indexPath.row])
        if viewModel.selectedCategory.value == viewModel.categories.value[indexPath.row] {
            cell.backgroundColor = .orange
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.selectedCategory.value != viewModel.categories.value[indexPath.row] {
            print(indexPath)
            let cellWillBeActive = collectionView.cellForItem(at: indexPath) as! CategoryCell
            cellWillBeActive.backgroundColor = .orange
            
            guard let previousCategory = viewModel.selectedCategory.value else { return }
            guard let previousCategoryIndex = viewModel.categories.value.firstIndex(of: previousCategory) else { return }
            let previousIndexPath = IndexPath(row: previousCategoryIndex, section: 0)
            
            if let cellWillBeDeactive = collectionView.cellForItem(at: previousIndexPath) as? CategoryCell {
                cellWillBeDeactive.backgroundColor = .systemGray6
            }
            
            viewModel.selectedCategory.value = viewModel.categories.value[indexPath.row]
        }
    }
}

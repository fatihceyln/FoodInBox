//
//  HomeScreen.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

class HomeScreen: FCDataLoadingVC {
    
    private let viewModel: HomeViewModel
    
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    private var categoriesView: CategoriesView!
    
    private var productsView: UIView!
    private var productsVC: ProductsVC!
    
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
        configureProductsView()
        
        addBinders()
        getNecessaryDataForView()
    }
    
    private func addBinders() {
        viewModel.categories.bind { [weak self] _ in
            guard let self = self else { return }
            
            self.categoriesView.collectionView.reloadData()
        }
        
        viewModel.selectedCategory.bind { [weak self] selectedCategory in
            guard let self = self else { return }
            
            guard let categoryId = selectedCategory?.categoryID else { return }
            self.productsVC.viewModel.getProducts(urlString: APIUrls.products(categoryId: categoryId))
            self.showLoadingView()
        }
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension HomeScreen {
    private func getNecessaryDataForView() {
        viewModel.getCategories()
    }
}

extension HomeScreen {
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
        stackView.distribution = .fill
        stackView.spacing = 10
        
        stackView.pinToEdges(of: scrollView)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func configureCategoriesView() {
        categoriesView = CategoriesView(frame: .zero)
        stackView.addArrangedSubview(categoriesView)
        
        categoriesView.collectionView.delegate = self
        categoriesView.collectionView.dataSource = self
        categoriesView.setTitle("Categories")
    }
    
    private func configureProductsView() {
        productsView = UIView(frame: .zero)
        productsView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 1).isActive = true
        
        stackView.setCustomSpacing(80, after: categoriesView)
        stackView.addArrangedSubview(productsView)
        
        productsVC = ProductsVC(service: ProductService(), delegate: self)
        add(childVC: productsVC, to: productsView)
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

extension HomeScreen: ProductsVCDelegate {
    func loadingStatusChanged(_ status: LoadingStatus) {
        if status == .finished {
            dismissLoadingView()
        }
    }
}

//
//  ProductsVC.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

class ProductsVC: UIViewController {
    
    let viewModel: ProductsViewModel
    
    private var collectionView: UICollectionView!
    
    init(service: ProductService) {
        viewModel = ProductsViewModel(service: service)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        
        addBinder()
        viewModel.getProducts()
    }
    
    private func addBinder() {
        viewModel.products.bind { [weak self] returnedProducts in
            guard let self = self else { return }
            
            self.collectionView.reloadData()
        }
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createCategoryFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.pinToEdges(of: view)
    }
}

extension ProductsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID, for: indexPath) as! ProductCell
        cell.set(viewModel.products.value[indexPath.row])
        
        return cell
    }
}

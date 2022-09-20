//
//  ProductsVC.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

enum LoadingStatus {
    case loading, finished
}

protocol ProductsVCDelegate: AnyObject {
    func loadingStatusChanged(_ status: LoadingStatus)
    func productSelected(_ product: ProductData)
}

class ProductsVC: UIViewController {
    
    let viewModel: ProductsViewModel
    private var collectionView: UICollectionView!
    
    private weak var delegate: ProductsVCDelegate!
    
    init(service: ProductService, delegate: ProductsVCDelegate) {
        viewModel = ProductsViewModel(service: service)
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        
        addBinder()
    }
    
    private func addBinder() {
        viewModel.products.bind { [weak self] returnedProducts in
            guard let self = self else { return }
        
            self.delegate.loadingStatusChanged(.finished)
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
        }
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createProductFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.pinToEdges(of: view)
    }
}

extension ProductsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID, for: indexPath) as! ProductCell
        cell.set(viewModel.products.value[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.products.value[indexPath.row]
        delegate.productSelected(product)
    }
}

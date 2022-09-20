//
//  ProductsVC.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import UIKit

class ProductsVC: UIViewController {
    
    let viewModel: ProductsViewModel
    
    init(service: ProductService) {
        viewModel = ProductsViewModel(service: service)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        addBinder()
        viewModel.getProducts()
        
        view.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(action))]
    }
    
    @objc func action() {
        print("a")
    }
    
    private func addBinder() {
        viewModel.products.bind { [weak self] returnedProducts in
            guard let _ = self else { return }
            
            print(returnedProducts)
        }
    }
}

//
//  CartScreen.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 21.09.2022.
//

import UIKit

class CartScreen: UIViewController {
    
    private var emptyStateView: EmptyStateView!
    private var tableView: UITableView!
    
    private var viewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configureEmptyStateView()
        configureTableView()
        
        addBinders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getProducts()
    }
    
    private func addBinders() {
        viewModel.products.bind { [weak self] products in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func configureEmptyStateView() {
        emptyStateView = EmptyStateView(title: "Your cart is empty! 😔", message: "Let's add some DELICIOUS dishes! 🤤")
        view.addSubview(emptyStateView)
        
        emptyStateView.pinToEdges(of: view)
    }
}

extension CartScreen {
    private func configureTableView() {
        tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.pinToEdges(of: view)
    }
}

extension CartScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.products.value[indexPath.row].title
        
        return cell
    }
}

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
    private var cartConfirmView: CartConfirmView!
    
    private var viewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Foods in Cart"
        navigationItem.backButtonTitle = "Back"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        configureEmptyStateView()
        configureCartConfirmView()
        configureTableView()
        
        addBinders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getProducts()
    }
    
    private func addBinders() {
        viewModel.products.bind { [weak self] products in
            guard let self = self else { return }
            
            if products.isEmpty {
                guard let emptyStateView = self.emptyStateView else { return }
                self.view.bringSubviewToFront(emptyStateView)
            } else {
                self.tableView.reloadData()
                self.cartConfirmView.setPrice(totalPrice: self.viewModel.totalPrice)
                
                guard let tableView = self.tableView, self.view.subviews.last != tableView else { return }
                self.view.bringSubviewToFront(tableView)
                self.view.bringSubviewToFront(self.cartConfirmView)
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
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cartConfirmView.topAnchor)
        ])
    }
    
    private func configureCartConfirmView() {
        cartConfirmView = CartConfirmView(delegate: self)
        view.addSubview(cartConfirmView)
        
        NSLayoutConstraint.activate([
            cartConfirmView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartConfirmView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartConfirmView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
        ])
    }
}

extension CartScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseID) as! CartCell
        cell.set(viewModel.products.value[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let productDetailVC = ProductDetailVC(product: viewModel.products.value[indexPath.row])
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

extension CartScreen: CartConfirmViewProtocol {
    func confirmButtonPressed() {
        viewModel.products.value.removeAll()
        
        ProductStore.removeAll()
    }
}

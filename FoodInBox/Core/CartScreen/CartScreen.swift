//
//  CartScreen.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 21.09.2022.
//

import UIKit

class CartScreen: UIViewController {
    
    private var emptyStateView: EmptyStateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureEmptyStateView()
    }
    
    private func configureEmptyStateView() {
        emptyStateView = EmptyStateView(title: "Your cart is empty! 😔", message: "Let's add some DELICIOUS dishes! 🤤")
        view.addSubview(emptyStateView)
        
        emptyStateView.pinToEdges(of: view)
    }
}

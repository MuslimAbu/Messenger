//
//  ConversationsViewController.swift
//  Messenger
//
//  Created by Муслим on 04.05.2024.
//

import UIKit

final class ConversationsViewController: UIViewController {
    
    private var isFirstLauch = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        title = "Чаты"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirstLauch {
            showLoginScreen()
        }
        isFirstLauch = false
    }
    
    private func showLoginScreen() {
        let viewController = LoginViewController()
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true)
    }
}

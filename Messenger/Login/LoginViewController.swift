//
//  LoginViewController.swift
//  Messenger
//
//  Created by Муслим on 04.05.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let mainView = LoginView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupActions()
    }
    
    // MARK: - Private methods
    
    private func setupActions() {
        mainView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchDown)
        mainView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchDown)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(registrationDidFinish),
            name: Notifications.registrationDidFinish,
            object: nil
        )
    }
    
    @objc
    private func loginButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func registerButtonTapped() {
        let viewController = RegisterViewController()
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true)
    }
    
    @objc
    private func registrationDidFinish() {
        dismiss(animated: true)
    }
}

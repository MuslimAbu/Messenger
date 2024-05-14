//
//  LoginViewController.swift
//  Messenger
//
//  Created by Муслим on 04.05.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let mainView = LoginView()
    private let networkService = LoginNetworkService()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        mainView.passwordTextField.isSecureTextEntry = true
        mainView.emailTextField.autocapitalizationType = .none
        
        setupActions()
    }
    
    // MARK: - Private methods
    
    private func setupActions() {
        mainView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchDown)
        mainView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchDown)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loginDidFinish),
            name: Notifications.loginDidFinish,
            object: nil
        )
    }
    
    @objc
    private func loginButtonTapped() {
        guard let email = mainView.emailTextField.text,
              let password = mainView.passwordTextField.text
        else {
            return
        }
        
        networkService.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let email):
                NotificationCenter.default.post(name: Notifications.loginDidFinish, object: nil)
                self.dismiss(animated: true)
            case .failure(let error):
                print(error)
            }
        }
        
        dismiss(animated: true)
    }
    
    @objc
    private func registerButtonTapped() {
        let viewController = RegisterViewController()
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true)
    }
    
    @objc
    private func loginDidFinish() {
        dismiss(animated: true)
    }
}

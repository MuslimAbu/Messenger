//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Муслим on 04.05.2024.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: UIViewController {

    // MARK: - UI Elements
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = LayoutMetrics.module * 10
        imageView.image = UIImage(named: "person_placeholder")
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let emailLabel = BaseComponentsFactory.makeGreetingLabel(title: nil)
    private let logOutButton = BaseComponentsFactory.makeActionButton(title: "Log out", color: .systemRed)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Profile"
        
        setupLayout()
        
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchDown)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailLabel.text = FirebaseAuth.Auth.auth().currentUser?.email
    }
    
    // MARK: - Private methods
    
    @objc
    private func logOutButtonTapped() {
        let alertController = UIAlertController(
            title: "Выйти из аккаунта?",
            message: "Действие нельзя будет обратить",
            preferredStyle: .actionSheet
        )
        
        let okAction = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            self?.handleLogOut()
        }
        
        let cancelAction = UIAlertAction(title: "Нет", style: .default)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    private func handleLogOut() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            showLoginScreen()
        } catch {
            print("Logout error")
        }
    }
    
    private func showLoginScreen() {
        let viewController = LoginViewController()
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true)
    }
}
    // MARK: - Layout

extension ProfileViewController {
    
    private func setupLayout() {
        setupEmailTextFieldLayout()
        setupEmailLabelLayout()
        setupLogOutButtonLayout()
    }
    
    private func setupEmailTextFieldLayout() {
        view.addSubview(profileImageView)
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutMetrics.halfModule * 3).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: LayoutMetrics.module * 20).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: LayoutMetrics.module * 20).isActive = true
    }
    
    private func setupEmailLabelLayout() {
        view.addSubview(emailLabel)
        
        emailLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: LayoutMetrics.module).isActive = true
    }
    
    private func setupLogOutButtonLayout() {
        view.addSubview(logOutButton)
        
        logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutMetrics.doubleModule).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutMetrics.doubleModule).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutMetrics.doubleModule).isActive = true
    }
}

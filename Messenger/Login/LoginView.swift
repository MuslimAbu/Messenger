//
//  LoginView.swift
//  Messenger
//
//  Created by Муслим on 04.05.2024.
//

import UIKit

final class LoginView: UIView {

    // MARK: UI elements
    
    private let greetingLabel = BaseComponentsFactory.makeGreetingLabel(title: "Welcome back! Glad to see you, Again!")
    private lazy var emailTextField = BaseComponentsFactory.makeTextField(placeholder: "Enter your email")
    private lazy var passwordTextField = BaseComponentsFactory.makeTextField(placeholder: "Enter your password")
    
    lazy var loginButton = BaseComponentsFactory.makeActionButton(title: "Login")
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register now", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemMint, for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setup(){
        setupLayout()
    }
    
    private func setupLayout(){
        setupGreetingLabelLayout()
        setupEmailTextFieldLayout()
        setupPasswordTextFieldLayout()
        setupLoginButtonLayout()
        setupRegisterButtonLayout()
    }
    
    private func setupGreetingLabelLayout() {
        addSubview(greetingLabel)
        
        greetingLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: LayoutMetrics.halfModule * 6
        ).isActive = true
        greetingLabel.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor,
            constant: LayoutMetrics.module * 10
        ).isActive = true
        greetingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutMetrics.halfModule * 6).isActive = true
    }
    
    private func setupEmailTextFieldLayout() {
        addSubview(emailTextField)
        
        emailTextField.topAnchor.constraint(
            equalTo: greetingLabel.bottomAnchor,
            constant: LayoutMetrics.doubleModule * 2
        ).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: greetingLabel.leadingAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: greetingLabel.trailingAnchor).isActive = true
    }
    
    private func setupPasswordTextFieldLayout() {
        addSubview(passwordTextField)
        
        passwordTextField.topAnchor.constraint(
            equalTo: emailTextField.bottomAnchor,
            constant: LayoutMetrics.doubleModule
        ).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor).isActive = true
    }
    
    private func setupLoginButtonLayout() {
        addSubview(loginButton)
        
        loginButton.leadingAnchor.constraint(equalTo: greetingLabel.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: greetingLabel.trailingAnchor).isActive = true
        loginButton.topAnchor.constraint(
            equalTo: passwordTextField.bottomAnchor,
            constant: LayoutMetrics.module * 7
        ).isActive = true
    }
    
    private func setupRegisterButtonLayout() {
        addSubview(registerButton)
        
        registerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -LayoutMetrics.module * 3).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}

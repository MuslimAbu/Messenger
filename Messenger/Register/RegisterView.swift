//
//  RegisterView.swift
//  Messenger
//
//  Created by Муслим on 05.05.2024.
//

import UIKit

final class RegisterView: UIView {
    
    var profilePicture: UIImage? {
        didSet {
            profileImageView.image = profilePicture
        }
    }
    
    private lazy var greetingLabel = BaseComponentsFactory.makeGreetingLabel(title: "Hello, Register to get started")
    lazy var usernameTextField = BaseComponentsFactory.makeTextField(placeholder: "Username")
    lazy var emailTextField = BaseComponentsFactory.makeTextField(placeholder: "Email")
    lazy var passwordTextField = BaseComponentsFactory.makeTextField(placeholder: "Password")
    lazy var confirmPasswordTextField = BaseComponentsFactory.makeTextField(placeholder: "Confirm password")
    
    lazy var registerButton = BaseComponentsFactory.makeActionButton(title: "Register")
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = LayoutMetrics.halfModule * 3
        return stackView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemMint, for: .normal)
        return button
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = LayoutMetrics.module * 10
        imageView.image = UIImage(named: "person_placeholder")
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setup() {
        setupLayout()
        
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        emailTextField.autocapitalizationType = .none
    }
    
    private func setupLayout() {
        setupGreetingLabelLayout()
        setupProfileImageViewLayout()
        setupStackViewLayout()
        setupLoginButtonLayout()
    }
    
    private func setupGreetingLabelLayout() {
        addSubview(greetingLabel)
        
        greetingLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: LayoutMetrics.halfModule * 6
        ).isActive = true
        greetingLabel.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor,
            constant: LayoutMetrics.halfModule * 10
        ).isActive = true
        greetingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutMetrics.halfModule * 6).isActive = true
    }
    
    private func setupProfileImageViewLayout() {
        addSubview(profileImageView)
        
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: LayoutMetrics.doubleModule).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: LayoutMetrics.module * 20).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: LayoutMetrics.module * 20).isActive = true
    }
    
    private func setupStackViewLayout() {
        addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: greetingLabel.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: greetingLabel.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: LayoutMetrics.doubleModule).isActive = true
        
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(registerButton)
        
        stackView.setCustomSpacing(LayoutMetrics.doubleModule * 2, after: confirmPasswordTextField)
    }
    
    private func setupLoginButtonLayout() {
        addSubview(loginButton)
        
        loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -LayoutMetrics.module * 3).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}

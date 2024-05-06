//
//  RegisterView.swift
//  Messenger
//
//  Created by Муслим on 05.05.2024.
//

import UIKit

final class RegisterView: UIView {
    
    private lazy var greetingLabel = BaseComponentsFactory.makeGreetingLabel(title: "Hello, Register to get started")
    private lazy var usernameTextField = BaseComponentsFactory.makeTextField(placeholder: "Username")
    private lazy var emailTextField = BaseComponentsFactory.makeTextField(placeholder: "Email")
    private lazy var passwordTextField = BaseComponentsFactory.makeTextField(placeholder: "Password")
    private lazy var confirmPasswordTextField = BaseComponentsFactory.makeTextField(placeholder: "Confirm password")
    
    init() {
        super.init(frame: .zero)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

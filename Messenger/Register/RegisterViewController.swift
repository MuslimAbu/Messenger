//
//  RegisterViewViewController.swift
//  Messenger
//
//  Created by Муслим on 04.05.2024.
//

import UIKit
import FirebaseAuth

final class RegisterViewController: UIViewController {
    
    private let mainView = RegisterView()
    private let networkService = RegisterNetworkService()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mainView.usernameTextField.delegate = self
        mainView.emailTextField.delegate = self
        mainView.passwordTextField.delegate = self
        mainView.confirmPasswordTextField.delegate = self
        
        setupActions()
    }
    
    private func setupActions() {
        mainView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchDown)
        
        mainView.profileImageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        )
        
        mainView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchDown)
    }
    
    @objc
    private func loginButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Data

extension RegisterViewController {
    
    @objc
    private func registerButtonTapped() {
        guard let email = mainView.emailTextField.text,
              let username = mainView.usernameTextField.text,
              let password = mainView.passwordTextField.text,
              let confirmation = mainView.confirmPasswordTextField.text
        else {
            return
        }
    
        let isUsernameValid = handleUsername(username)
        let isEmailValid = handleEmail(email)
        let isPasswordValie = handlePassword(password, confirmation: confirmation)
        
        guard isUsernameValid, isEmailValid, isPasswordValie else { return }
        
        networkService.register(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let email):
                let user = User(username: username, email: email)
                
                UserDefaults.standard.set(user.email, forKey: "user_email")
                UserDefaults.standard.set(user.username, forKey: "user_username")
                
                DatabaseManager.shared.saveUser(user)
                
                self.uploadProfilePicture(user: user)
                
                self.dismiss(animated: true) {
                        NotificationCenter.default.post(name: Notifications.loginDidFinish, object: nil)
                
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func uploadProfilePicture(user: User) {
        guard let profilePicture = self.mainView.profilePicture,
              let data = profilePicture.pngData()
        else {
            return
        }
        
        StorageManager.shared.upload(data: data, filename: user.pictureFilename) { result in
            switch result {
            case .success:
                UserDefaults.standard.set(data, forKey: "user_profilepicture")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func handleEmail(_ email: String) -> Bool {
        guard email.count >= 6,
              email.firstIndex(of: "@") != nil,
              email.firstIndex(of: ".") != nil
        else {
            showAlert(title: "Ошибка", message: "Неверный email")
            return false
        }
        
        return true
    }
    
    private func handleUsername(_ username: String) -> Bool {
        guard username.count >= 6 else {
            showAlert(title: "Ошибка", message: "Неверный username")
            return false
        }
        
        return true
    }
    
    private func handlePassword(_ password: String, confirmation: String) -> Bool {
        if password.count < 8 {
            showAlert(title: "Ошибка", message: "Длина пароля меньше 8 символов")
            return false
        }
        
        if password != confirmation {
            showAlert(title: "Ошибка", message: "Пароли не совпадают")
            return false
        }
        
        return true
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}

// MARK: - Image picker

extension RegisterViewController {
    
    @objc
    private func profileImageViewTapped() {
        let alertController = UIAlertController(title: "Выберите способ", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "При помощи камеры", style: .default) { [weak self] _ in
            self?.showCameraPicker()
        }
        let libraryAction = UIAlertAction(title: "Из библиотеки", style: .default) { [weak self] _ in
            self?.showGalleryPicker()
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        
        present(alertController, animated: true)
    }
    
    private func showCameraPicker() {
        let viewController = UIImagePickerController()
        viewController.delegate = self
        viewController.sourceType = .camera
        viewController.allowsEditing = true
        
        present(viewController, animated: true)
    }
    
    private func showGalleryPicker() {
        let viewController = UIImagePickerController()
        viewController.delegate = self
        viewController.sourceType = .photoLibrary
        viewController.allowsEditing = true
        
        present(viewController, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegisterViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[.editedImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        
        mainView.profilePicture = image
        
        picker.dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === mainView.usernameTextField {
            mainView.emailTextField.becomeFirstResponder()
        } else if textField == mainView.emailTextField {
            mainView.passwordTextField.becomeFirstResponder()
        } else if textField === mainView.passwordTextField {
            mainView.confirmPasswordTextField.becomeFirstResponder()
        } else {
            mainView.confirmPasswordTextField.becomeFirstResponder()
            registerButtonTapped()
        }
        
        return true
    }
}

// MARK: - UINavigationControllerDelegate

extension RegisterViewController: UINavigationControllerDelegate {}

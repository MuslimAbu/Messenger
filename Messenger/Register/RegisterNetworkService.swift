//
//  RegisterNetworkService.swift
//  Messenger
//
//  Created by Муслим on 11.05.2024.
//

import Foundation
import FirebaseAuth

final class RegisterNetworkService {
    
    enum RegistrationError: Error {
        case error(String)
    }
    
    func register(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let result = result, let email = result.user.email, error == nil else {
                completion(
                    .failure(
                        RegistrationError.error("User creation error")
                    )
                )
                return
            }
            
            completion(.success(email))
        }
    }
}

//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Муслим on 16.05.2024.
//

import Foundation
import FirebaseDatabase

struct DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = FirebaseDatabase.Database.database().reference()
    
    private init() {}
}

// MARK: - Account manager

extension DatabaseManager {
    
    enum DatabaseManagerError: Error {
        case error
    }
    
    func saveUser(_ user: User) {
        let userData = [
            "username": user.username.safe
        ]
        
        database.child(user.email.safe).setValue(userData)
    }
    
    func getUser(email: String, completion: @escaping (Result<User, Error>) -> Void) {
        database.child(email.safe).observeSingleEvent(of: .value) { snapshot in
            guard let data = snapshot.value as? [String: String],
                  let username = data["username"]
            else {
                completion(
                    .failure(DatabaseManagerError.error)
                )
                return
            }
            
            let user = User(username: username, email: email)
            
            completion(
                .success(user)
            )
        }
    }
}

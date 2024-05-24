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
        case allUsers
    }
    
    func saveUser(_ user: User) {
        let userData = [
            "username": user.username.safe
        ]
        
        database.child(user.email.safe).setValue(userData) { error, reference in
            guard error == nil else {
                return
            }
            
            database.child("users").observeSingleEvent(of: .value) { snapshot in
                let user = [
                    "email": user.email.safe,
                    "username": user.username.safe
                ]
                
                if var users = snapshot.value as? [[String : String]] {
                    users.append(user)
                    database.child("users").setValue(users)
                } else {
                    database.child("users").setValue([user])
                }
            }
        }
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
    
    func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void) {
        database.child("users").observeSingleEvent(of: .value) { snapshot in
            guard let users = snapshot.value as? [[String: String]] else {
                completion(
                    .failure(DatabaseManagerError.allUsers)
                )
                return
            }
            
            completion(
                .success(users)
            )
        }
    }
}

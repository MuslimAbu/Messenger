//
//  StorageManager.swift
//  Messenger
//
//  Created by Муслим on 18.05.2024.
//

import FirebaseStorage
import Foundation

struct StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = FirebaseStorage.Storage.storage().reference()
    
    private init() {}
}

// MARK: - Profile picture

extension StorageManager {
    
    enum StorageMangerError: Error {
        case uploadPictureError
    }
    
    func upload(data: Data, filename: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("images/\(filename).png").putData(data) { data, error in
            guard let data = data, error == nil else {
                completion(
                    .failure(StorageMangerError.uploadPictureError)
                )
                return
            }
            
            completion(
                .success("")
            )
        }
    }
}


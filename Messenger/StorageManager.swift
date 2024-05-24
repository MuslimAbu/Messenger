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
        case downloadUrlError
    }
    
    func upload(data: Data, filename: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("images/\(filename).png").putData(data) { data, error in
            guard let data = data, error == nil else {
                completion(
                    .failure(StorageMangerError.uploadPictureError)
                )
                return
            }
        }
    }
    
    func url(for path: String, completion: @escaping(Result<URL, Error>) -> Void) {
        storage.child(path).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(
                    .failure(StorageMangerError.downloadUrlError)
                )
                return
            }
            
            completion(
                .success(url)
            )
        }
    }
}

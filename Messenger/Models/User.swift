//
//  User.swift
//  Messenger
//
//  Created by Муслим on 16.05.2024.
//

import Foundation

struct User {
    let username: String
    let email: String
    
    var pictureFilename: String {
        email.safe + "-picture"
    }
}

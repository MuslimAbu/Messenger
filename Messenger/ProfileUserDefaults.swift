//
//  ProfileUserDefaults.swift
//  Messenger
//
//  Created by Муслим on 30.05.2024.
//

import Foundation

struct ProfileUserDefaults {
    
    private enum Keys: String {
        case email = "user_email"
        case username = "user_username"
        case avatarUrl = "user_avatar"
        case avatarData = "user_avatar_data"
    }
    
    private static let defaults = UserDefaults.standard
    
    static var username: String? {
        defaults.value(forKey: Keys.username.rawValue) as? String
    }
    
    static var email: String? {
        defaults.value(forKey: Keys.email.rawValue) as? String
    }
    
    static var avatarUrl: String? {
        defaults.value(forKey: Keys.avatarUrl.rawValue) as? String
    }
    
    static var avatarData: Data? {
        defaults.value(forKey: Keys.avatarData.rawValue) as? Data
    }
    
    static func handleAvatarUrl(_ url: URL?) {
        defaults.set(url?.absoluteString, forKey: Keys.avatarUrl.rawValue)
    }
    
    static func handleAvatarData(_ data: Data?) {
        defaults.set(data, forKey: Keys.avatarData.rawValue)
    }
    
    static func handleUser(_ user: User) {
        defaults.set(user.username, forKey: Keys.username.rawValue)
        defaults.set(user.email, forKey: Keys.email.rawValue)
    }
}

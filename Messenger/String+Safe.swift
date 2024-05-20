//
//  String+Safe.swift
//  Messenger
//
//  Created by Муслим on 16.05.2024.
//

import Foundation

extension String {
    var safe: String {
        self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}

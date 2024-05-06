//
//  MainTabBarController.swift
//  Messenger
//
//  Created by Муслим on 04.05.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private var conversationViewController: UINavigationController {
        let viewController = ConversationsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Chats",
            image: UIImage(systemName: "message"),
            selectedImage: UIImage(systemName: "message.fill"))
        return navigationController
    }
    
    private var profileViewController: UINavigationController {
        let viewController = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))
        return navigationController
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [conversationViewController, profileViewController]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

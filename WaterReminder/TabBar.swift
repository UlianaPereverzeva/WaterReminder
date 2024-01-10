//
//  TabBar.swift
//  WaterReminder
//
//  Created by ульяна on 4.01.24.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .black
        
        tabBar.tintColor = UIColor(red: 0.31, green: 0.02, blue: 0.66, alpha: 1.00)
        setupVCs()
    }
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: Main(), title: NSLocalizedString("Main", comment: ""), image: UIImage(systemName: "drop")!),
            createNavController(for: MyAccount(), title: NSLocalizedString("MyAccount", comment: ""), image: UIImage(systemName: "person")!),
            createNavController(for: RemindersViewController(), title: NSLocalizedString("Reminders", comment: ""), image: UIImage(systemName: "bell.badge")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}

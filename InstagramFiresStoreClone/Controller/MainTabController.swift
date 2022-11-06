//
//  MainTabController.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/6/22.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarConfiguration()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    func tabBarConfiguration() {
        if #available(iOS 15.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
    
    func configureViewControllers() {
        
        
        view.backgroundColor = .white
        
        let feed = customNavigationController(unselectedImage: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"), rootViewController: FeedController())
        let search = customNavigationController(unselectedImage: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"), rootViewController: SearchController())
        let imageSelector = customNavigationController(unselectedImage: UIImage(systemName: "plus.square"), selectedImage: UIImage(systemName: "plus.square.fill"), rootViewController: ImageSelectorController())
        let notifications = customNavigationController(unselectedImage: UIImage(systemName: "bubble.left"), selectedImage: UIImage(systemName: "bubble.left.fill"), rootViewController: NotificationsController())
        let profile = customNavigationController(unselectedImage: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"), rootViewController: ProfileController())
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
    }
    
    func customNavigationController(unselectedImage: UIImage!, selectedImage: UIImage!, rootViewController: UIViewController) -> UINavigationController {
        
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        
        return navigation
    }
    
}

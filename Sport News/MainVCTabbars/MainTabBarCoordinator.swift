//
//  MainTabBarCoordinator.swift
//  Sport News
//
//  Created by Abdusalom on 18/07/2024.
//


import UIKit


class MainTabBarCoordinator: BaseCoordinator {
    
    var tabBarController: UITabBarController
    
    
    override init(navigationController: UINavigationController) {
        self.tabBarController = UITabBarController()
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        
        let feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
        let sectionsCoordinator = SectionsCoordinator(navigationController: UINavigationController())
        let followCoordinator = FollowCoordinator(navigationController: UINavigationController())
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        
        feedCoordinator.start()
        sectionsCoordinator.start()
        followCoordinator.start()
        profileCoordinator.start()
        
        tabBarController.viewControllers = [
            feedCoordinator.navigationController,
            sectionsCoordinator.navigationController,
            followCoordinator.navigationController,
            profileCoordinator.navigationController
        ]
        
        feedCoordinator.navigationController.setNavigationBarHidden(true, animated: false)
        feedCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed"), tag: 0)
        feedCoordinator.navigationController.tabBarItem.configureTabBarItemApperance()
        
        sectionsCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Sections", image: UIImage(named: "sections"), tag: 1)
        sectionsCoordinator.navigationController.tabBarItem.configureTabBarItemApperance()
        
        followCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Follow", image: UIImage(named: "follow"), tag: 2)
        followCoordinator.navigationController.tabBarItem.configureTabBarItemApperance()
        
        profileCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 3)
        profileCoordinator.navigationController.tabBarItem.configureTabBarItemApperance()
        
        navigationController.pushViewController(tabBarController, animated: true)
        tabBarController.configureTabBarAppearance()
 
    }
}


extension UITabBarController {
    func configureTabBarAppearance() {
        tabBar.tintColor = .red
        tabBar.barTintColor = .white
        tabBar.layer.borderWidth = 0.5
        tabBar.backgroundColor = .black
    }
}

extension UITabBarItem {
    func configureTabBarItemApperance() {
        self.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .semibold)], for: .normal)
    }
}


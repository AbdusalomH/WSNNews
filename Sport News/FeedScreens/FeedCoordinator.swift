//
//  FeedsCoordinator.swift
//  Sport News
//
//  Created by Abdusalom on 12/07/2024.
//

import UIKit

class FeedCoordinator: BaseCoordinator {
    
    
    override func start() {
        showFeedMainScreen()
    }
    
    private func showFeedMainScreen() {
        let feedVC = FeedVC()
        feedVC.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(feedVC, animated: true)
    }
    
    
}

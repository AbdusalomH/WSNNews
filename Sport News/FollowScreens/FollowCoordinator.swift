//
//  FollowCoordinator.swift
//  Sport News
//
//  Created by Abdusalom on 18/07/2024.
//

import UIKit


class FollowCoordinator: BaseCoordinator {
    
    override func start() {
        let follow = FollowVC()
        navigationController.pushViewController(follow, animated: true)
    }
    
}

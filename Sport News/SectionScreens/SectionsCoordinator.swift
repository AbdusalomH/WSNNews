//
//  SectionsCoordinator.swift
//  Sport News
//
//  Created by Abdusalom on 18/07/2024.
//

import UIKit


class SectionsCoordinator: BaseCoordinator {
    
    override func start() {
        let sections = SectionsVC()
        navigationController.pushViewController(sections, animated: true)
    }
}

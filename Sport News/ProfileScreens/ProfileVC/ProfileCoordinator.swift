//
//  ProfileCoordinator.swift
//  Sport News
//
//  Created by Abdusalom on 18/07/2024.
//

import UIKit
import KeychainAccess


class ProfileCoordinator: BaseCoordinator {
    
    var isLoggedIn: String {
        return KeychainManager.shared.getUserInfo().email ?? ""
    }

    override func start() {
        
        if isLoggedIn.isEmpty {
            let profileAuth = ProfileAuthVC()
            profileAuth.profileCoordinator = self
            navigationController.pushViewController(profileAuth, animated: true)
        } else {
            let profile = ProfileVC()
            profile.profileCoordinator = self
            navigationController.pushViewController(profile, animated: true)
        }
    }
    
    func showProfileAuth() {
        let profileAuth = ProfileAuthVC()
        profileAuth.profileCoordinator = self
        navigationController.pushViewController(profileAuth, animated: true)
    }
    
    func showSignIn() {
        let auth = LoginPageVC()
        auth.state = .signIn
        auth.profileCoordinator = self
        navigationController.pushViewController(auth, animated: true)
    }
    
    func showSignUp() {
        let signin = LoginPageVC()
        signin.state = .signUp
        signin.profileCoordinator = self
        navigationController.pushViewController(signin, animated: true)
    }
    
    func showProfile() {
        let profile = ProfileVC()
        navigationController.pushViewController(profile, animated: true)
    }
    
    func showSettingProfile() {
        let setting = SettingsVC()
        navigationController.pushViewController(setting, animated: true)
    }
}



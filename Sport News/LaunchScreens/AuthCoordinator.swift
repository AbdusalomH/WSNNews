//
//  AppCoordinator.swift
//  Sport News
//
//  Created by Abdusalom on 12/07/2024.
//

import UIKit



class AuthCoordinator: BaseCoordinator {
    
 
    override func start() {
        showLaunch()
    }

    private func showLaunch() {
        let launchVC = LaunchVC()
        launchVC.authCoordinator = self
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(launchVC, animated: true)
    }

    func showSignUp() {
        let signUpVC = SignUpVC()
        signUpVC.coordinator = self
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func showProfile() {
        let profileVC = ProfileAuthVC()
        profileVC.authCoordinator = self
        navigationController.pushViewController(profileVC, animated: true)
    }
    
    func showPrivacyDetails() {
        let privacyDetails = PrivacyPolicyVC()
        privacyDetails.authcoordinator = self
        privacyDetails.title = "Privacy policy"
        navigationController.pushViewController(privacyDetails, animated: true)
    }
    
    func showTermOfUse() {
        let terms = TermsOfUseVC()
        terms.authcoordinator = self
        terms.title = "Terms of use"
        navigationController.pushViewController(terms, animated: true)
    }
}


extension AuthCoordinator: SignUpDelegate {
    
    func showPrivacy() {
        let privacy = PrivacyVC()
        privacy.authCoordinator = self
        
        navigationController.pushViewController(privacy, animated: true)
    }
    

    func privacy() {
        let privacyVC = PrivacyVC()
        privacyVC.authCoordinator = self
        navigationController.pushViewController(privacyVC, animated: true)
    }
    
    
    func showLoginVC(state: LoginState) {
        let loginPageVC = LoginPageVC()
        loginPageVC.delegate = self
        loginPageVC.state = state
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(loginPageVC, animated: true)
    }
        
    func showMainTabBar() {
        let mainTabBarCoordinator = MainTabBarCoordinator(navigationController: navigationController)
        mainTabBarCoordinator.start()
    }
}


extension AuthCoordinator: PrivacyDelegate {
    func showFavoriteList() {
        let favoritePage = FavoritesSelectionVC()
        favoritePage.coordinator = self
        navigationController.pushViewController(favoritePage, animated: true)
    }
}



extension AuthCoordinator: ProfileDelegate {
    func showProvacy() {
        let privacyVC = PrivacyVC()
        privacyVC.authCoordinator = self
        navigationController.pushViewController(privacyVC, animated: true)
    }
    
    func showLoginPage(state: LoginState) {
        let signUpVC = LoginPageVC()
        signUpVC.state = state
        navigationController.pushViewController(signUpVC, animated: true)
    }
}


extension AuthCoordinator: LoginPageVCDelegate  {
    func loginPageVCDidClose() {
        showPrivacy()
    }
}









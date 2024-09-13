//
//  AuthViewModel.swift
//  Sport News
//
//  Created by Abdusalom on 01/09/2024.
//

import Foundation


protocol LogingViewModelDelegate: AnyObject {
    func didLoginSuccessfully()
    func didFailLogin()
}


class AuthViewModel {
    
    
    weak var delegate: LogingViewModelDelegate?
    
    
    func login(email: String, password: String) {

        Task {
            do {
                let success = try await AuthsNetworkManager().loginAuth(email: email, password: password)
                print("success")
                KeychainManager.shared.saveUserInfo(username: success.profile.username, email: success.profile.email)
                KeychainManager.shared.saveToken(accessToken: success.access_token)
                KeychainManager.shared.saveRefreshToken(refreshToken: success.refresh_token)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoginSuccessfully()
                }
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.didFailLogin()
                }
                print("no way")
            }
        }
    }
    
    func signUp(username: String, email: String, password: String) {
        
        Task {
            do {
                let success = try await AuthsNetworkManager().signUp(username: username, email: email, password: password)
                print("success")
                KeychainManager.shared.saveUserInfo(username: success.profile.username, email: success.profile.email)
                KeychainManager.shared.saveToken(accessToken: success.access_token)
                KeychainManager.shared.saveRefreshToken(refreshToken: success.refresh_token)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoginSuccessfully()
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.didFailLogin()
                }
                print("no way")
            }
        }  
    }
}

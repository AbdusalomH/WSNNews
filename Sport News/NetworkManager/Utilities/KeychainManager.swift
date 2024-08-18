//
//  TokenManager.swift
//  Sport News
//
//  Created by Abdusalom on 25/07/2024.
//

import Foundation
import KeychainAccess


class KeychainManager {
    
    static let shared = KeychainManager()
    
    init() {}
    
    let keychain = Keychain(service: "com.example.github-token")
    
    func removedAll() {
        do {
            try keychain.removeAll()
        } catch {
            print(error)
        }
    }

    
    func saveToken(accessToken: String) {
        
        do {
            try keychain.set(accessToken, key: "token")
        } catch {
            print(error)
        }
    }
    
    func saveRefreshToken(refreshToken: String) {
        
        do {
            try keychain.set(refreshToken, key: "refreshToken")
        } catch {
            print(error)
        }
    }
    
    
    func getToken() -> String? {
        let token = try? keychain.getString("token")
        return token
    }
    
    
    func saveUserInfo(username: String, email: String) {
        do {
            try keychain.set(username, key: "username")
            try keychain.set(email, key: "email")
        } catch {
            print(error)
        }
    }
    
    func getUserInfo() -> (username: String?, email: String?) {
        let username = try? keychain.getString("username")
        let email = try? keychain.getString("email")
        return (username, email)
    }
}



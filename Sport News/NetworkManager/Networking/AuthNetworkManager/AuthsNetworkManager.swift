//
//  AuthsNetworkManager.swift
//  Sport News
//
//  Created by Abdusalom on 13/09/2024.
//

import Foundation

protocol AuthsNetworkProtocol: AnyObject {
    
    func loginAuth(email: String, password: String) async throws -> AuthModel
    
    func signUp(username: String, email: String, password: String) async throws -> AuthModel
    
    func anonymus() async throws -> AuthModel
    
    func restorePassword(oldPassword: String, newPassword: String) async throws -> PasswordChange

}



final class AuthsNetworkManager: AuthsNetworkProtocol {
    
    
    
    func restorePassword(oldPassword: String, newPassword: String) async throws -> PasswordChange {
        
        do {
            let changed = try await AuthsNetRouter<AuthEndpoint, PasswordChange>().authsRequst(rout: .restorePassword(oldPassword: oldPassword, newPassword: newPassword))
            return changed
        } catch {
            throw error
        }
    }
    
    
    
    func anonymus() async throws -> AuthModel {
        
        let newEmail = "\(UUID().uuidString)@m.com"
        let password = "Test\(Int.random(in: 0...1000))"
        let randomUser = Int.random(in: 0...1000)
        
        
        do {
            let anonymusDetails = try await AuthsNetRouter<AuthEndpoint, AuthModel>().authsRequst(rout: .anonymusSignUp(username: "Username \(randomUser)", email: newEmail, password: password))
            return anonymusDetails
        } catch {
            throw error
        }
    }
    
    
    
    func signUp(username: String, email: String, password: String) async throws -> AuthModel {
        
        do {
            let signUpDetails = try await AuthsNetRouter<AuthEndpoint, AuthModel>().authsRequst(rout: .signUp(username: username, email: email, password: password))
            return signUpDetails
        } catch {
            throw error
        }
    }
    
    
    
    func loginAuth(email: String, password: String) async throws -> AuthModel {
        
        do {
            let authDetails = try await AuthsNetRouter<AuthEndpoint, AuthModel>().authsRequst(rout: .signIn(email: email, password: password))
            return authDetails
        } catch {
            throw error
        }
    }
}




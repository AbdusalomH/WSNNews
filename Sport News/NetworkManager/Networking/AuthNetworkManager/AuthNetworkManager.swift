//
//  Configuration.swift
//  Sport News
//
//  Created by Abdusalom on 01/08/2024.
//

import Foundation
import Alamofire

protocol RestoreProtocol {
    typealias ChangeCompletion = (_ restoreMode: PasswordChange?, _ error: WSNErrors) -> ()
    
    func changePassword(old: String, new: String, completion: @escaping ChangeCompletion)
}


protocol AuthProtocol {
    
    typealias AuthCompletion = (_ authmodel: AuthModel?, _ error: WSNErrors?) -> ()
    
    func loginFetch(email: String, password: String, completion: @escaping AuthCompletion)
    
    func signUpFetch(username: String, email: String, password: String, completion: @escaping AuthCompletion)
    
    func anonymusFetch(completion: @escaping AuthCompletion)
}


class AuthNetworkManager: AuthProtocol {
    
    
    func anonymusFetch(completion: @escaping AuthCompletion) {
        
        let newEmail = "\(UUID().uuidString)@m.com"
        let password = "Test\(Int.random(in: 0...1000))"
        let randomUser = Int.random(in: 0...1000)
        
        AuthNetRouter<AuthEndpoint, AuthModel>().authRequest(.anonymusSignUp(username: "username\(randomUser)", email: newEmail, password: password)) { response in

            switch response.result {
                case .success(let success):
                    completion(success, nil)
                case .failure(let failure):
                print(failure.errorDescription ?? failure.localizedDescription)
            }
        }
    }
    

    
    
    func loginFetch(email: String, password: String, completion: @escaping AuthCompletion) {
        
        AuthNetRouter<AuthEndpoint, AuthModel>().authRequest(.signIn(email: email, password: password)) { response in
            
            switch response.result {
            case .success(let success):
                
                completion(success, nil)
                
            case .failure(let error):
               
                print(error.errorDescription ?? error.localizedDescription)
                
                if response.response?.statusCode == 400 {
                    completion(nil, .invalidUsername)
                }
                
                completion(nil, .invalidData)
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print(utf8Text)
                }
            }
        }
    }
    
    
    func signUpFetch(username: String, email: String, password: String, completion: @escaping AuthCompletion) {
        
        AuthNetRouter<AuthEndpoint, AuthModel>().authRequest(.signUp(username: username, email: email, password: password)) { response in
            switch response.result {
                case .success(let success):
                    completion(success, nil)
                case .failure(let error):
                    print(error)
                    completion(nil, .invalidData)
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print(utf8Text)
                }
            }
        }
    }
}



extension AuthNetworkManager: RestoreProtocol {
    
    func changePassword(old: String, new: String, completion: @escaping ChangeCompletion) {
        
        AuthNetRouter<AuthEndpoint, PasswordChange>().authRequest(.restorePassword(oldPassword: old, newPassword: new)) { response in
            switch response.result {
            case .success(let newToken):
                print(newToken)
            case .failure(let error):
                print(error)
            }
        }
    }
}

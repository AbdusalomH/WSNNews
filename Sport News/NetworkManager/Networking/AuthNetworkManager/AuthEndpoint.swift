//
//  SiginInEndpoint.swift
//  Sport News
//
//  Created by Abdusalom on 01/08/2024.
//

import Foundation
import Alamofire

enum AuthEndpoint {
    case signIn(email: String, password: String)
    case signUp(username: String, email: String, password: String)
    case anonymusSignUp(username: String, email: String, password: String)
    case restorePassword(oldPassword: String, newPassword: String)
}

extension AuthEndpoint: AuthRouting {

    
    var baseURL: String {
        return API.configure(scheme: .https, domain: Configuration.baseUrl, version: .v1)
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/sign-in/email/"
        case .signUp:
            return "/sign-up/email/"
        case .anonymusSignUp:
            return "/sign-up/email/"
        case .restorePassword:
            return "/password/change/"
        }
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: Parameters {
        
        switch self {
            
        case .signIn(email: let email, password: let password):
            
            return [
                "username": "string",
                "email" : email,
                "password": password,
                "city": "string",
                "sex": 0,
                "year_of_birth": 0,
                "country": "us",
                "gclid": "string"
            ]
            
        case .signUp(username: let username, email: let email, password: let password):
            
            return [
                "username": username,
                "email" : email,
                "password": password,
                "city": "string",
                "sex": 0,
                "year_of_birth": 0,
                "country": "us",
                "gclid": "string"
            ]
            
        case .anonymusSignUp(username: let username, email: let email, password: let password):
            return [
                "username": username,
                "email" : email,
                "password": password,
                "city": "string",
                "sex": 0,
                "year_of_birth": 0,
                "country": "us",
                "gclid": "string"
            ]
        case .restorePassword(oldPassword: let oldPassword, newPassword: let newPassword):
            return [
                "old_password" : oldPassword,
                "new_password" : newPassword
            ]
        }
    }
}






//
//  GetNewsEndpoint.swift
//  Sport News
//
//  Created by Abdusalom on 04/08/2024.
//

import Foundation
import Alamofire

let token = KeychainManager.shared.getToken()
let applicationJson = "application/json"


enum CodableType {
    case encoding
    case decoding
}

extension CodableType {
    
    
}

enum GetNewsEndpoint {
    
    case getNews(pageIndex: Int, count: Int)
    case getNewsByID(id: Int)
    case getNewsCommentByID(id: Int)
//    case postCommentByID
//    case postLikesByID
//    case removeLikesByID
}

extension GetNewsEndpoint: NewsRouting {

    
    var baseURL: String {
        return API.configure(scheme: .https, domain: Configuration.baseUrl, version: .v1)
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        
        switch self {
            
        case .getNews(let pageIndex, let count):
            return "/news/?page_index=\(pageIndex)&page_size=\(count)"
            
        case .getNewsByID(id: let id):
            return "/news/\(id)"
            
        case .getNewsCommentByID(id: let id):
            return "/news/\(id)/comments/"
            //return "/news/357/comments/?page_index=1&page_size=10"
        
        
        }
    }
    

    
    var headers: HTTPHeaders {
        return [
                "Content-Type": applicationJson,
                "Autorizaton" : "\(String(describing: token))",
            ]
    }
}

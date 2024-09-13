//
//  AuthsNetRouter.swift
//  Sport News
//
//  Created by Abdusalom on 13/09/2024.
//

import Foundation
import Alamofire


protocol AuthsNetProtocol: AnyObject {
    
    associatedtype Endpoint: AuthRouting
    associatedtype ParseData: Decodable
    
    func authsRequst(rout: Endpoint) async throws -> ParseData
    
}

final class AuthsNetRouter<Endpoint: AuthRouting, ParseData: Decodable>: AuthsNetProtocol {
    
    
    func authsRequst(rout: Endpoint) async throws -> ParseData {
        
        return try await withCheckedThrowingContinuation { continuation in
            
            AF.request(rout.baseUrlWithPath, method: rout.method, parameters: rout.parameters, encoding: rout.encoding, headers: rout.headers).responseDecodable(of: ParseData.self) { rsts in
                
            switch rsts.result {
                
                case .success(let data):
                continuation.resume(returning: data)
                
                case .failure(let error):
                continuation.resume(throwing: error as Error)
                
                }
            }
        }
    }
}

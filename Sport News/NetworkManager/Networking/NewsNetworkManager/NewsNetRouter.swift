//
//  NewsNetRouter.swift
//  Sport News
//
//  Created by Abdusalom on 04/08/2024.
//

import Foundation
import Alamofire

typealias NewsNetWorkRouterCompletion<T> = ((AFDataResponse<T>) -> Void) where T : Decodable


protocol NewsNetworkRouter: AnyObject {
    
    associatedtype Endpoint: NewsRouting
    associatedtype ParseData: Decodable
    
 //   func newsRequest(_ route: Endpoint, completion: @escaping NewsNetWorkRouterCompletion<ParseData>)
    
    func feedRequest(_ route: Endpoint) async throws -> ParseData

}

//создаем final class  который реализует сам запрос
final class NewsNetRouter<Endpoint: NewsRouting, ParseData: Decodable>: NewsNetworkRouter {
    
    func feedRequest(_ route: Endpoint) async throws -> ParseData {
        
        return try await withCheckedThrowingContinuation { contunation in
            
            AF.request(route.baseUrlWithPath, method: route.method, parameters: route.parameters, headers: route.headers).responseDecodable(of: ParseData.self) { response in
                
                
                switch response.result {
                    
                case .success(let success):
                    contunation.resume(returning: success)
                case .failure(let error):
                    contunation.resume(throwing: error as AFError)
                }
            }
        }
    }
    
    
//
//    
//    func newsRequest(_ route: Endpoint, completion: @escaping NewsNetWorkRouterCompletion<ParseData>) {
//    
//            AF.request(route.baseUrlWithPath, method: route.method, parameters: route.parameters, headers: route.headers).responseDecodable(of: ParseData.self, completionHandler: completion)
//    }
}





//
//  NetRouter.swift
//  Sport News
//
//  Created by Abdusalom on 01/08/2024.
//

import Foundation
import Alamofire



typealias AuthNetWorkRouterCompletion<T> = ((AFDataResponse<T>) -> Void) where T : Decodable

protocol AuthNetworkRouter: AnyObject {
    
    associatedtype Endpoint: AuthRouting
    associatedtype ParseData: Decodable
    
    func authRequest(_ route: Endpoint, completion: @escaping AuthNetWorkRouterCompletion<ParseData>)
    
}

//создаем final class  который реализует сам запрос
final class AuthNetRouter<EndPoint: AuthRouting, ParseData: Decodable>: AuthNetworkRouter{
    
    func authRequest(_ route: EndPoint, completion: @escaping AuthNetWorkRouterCompletion<ParseData>) {
        
        AF.request(route.baseUrlWithPath,
                   method: route.method,
                          parameters: route.parameters,
                          encoding: route.encoding, // Используем кодирование из протокола
                          headers: route.headers).responseDecodable(of: ParseData.self, completionHandler: completion)
    }  
}






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
    
    func newsRequest(_ route: Endpoint, completion: @escaping NewsNetWorkRouterCompletion<ParseData>)
    
}

//создаем final class  который реализует сам запрос
final class NewsNetRouter<Endpoint: NewsRouting, ParseData: Decodable>: NewsNetworkRouter {
    
    
    //
    //    func newsRequest(_ route: Endpoint, completion: @escaping NewsNetWorkRouterCompletion<ParseData>) {
    //        print(route.baseURL)
    //
    //        AF.request(route.baseUrlWithPath, method: route.method, parameters: route.parameters, headers: route.headers).responseDecodable(of: ParseData.self, completionHandler: completion)
    //    }
    
    
    func newsRequest(_ route: Endpoint, completion: @escaping NewsNetWorkRouterCompletion<ParseData>) {
        
        AF.request(route.baseUrlWithPath, method: route.method, parameters: route.parameters, headers: route.headers)
            .validate() // Добавим валидацию, чтобы отлавливать HTTP ошибки
            .responseDecodable(of: ParseData.self) { response in
                switch response.result {
                case .success(let data):
                    completion(response)
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    print("Response data: \(String(describing: response.data))")
                    completion(response)
                }
            }
    }
}


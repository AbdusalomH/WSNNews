//
//  Routing.swift
//  Sport News
//
//  Created by Abdusalom on 01/08/2024.
//

import Foundation
import Alamofire

protocol AuthRouting {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var headers: HTTPHeaders { get }
    var baseUrlWithPath: String { get }
    var encoding: ParameterEncoding { get } // Добавляем параметр для кодирования
}

extension AuthRouting {
    var method: HTTPMethod {return .post}
    var parameters: Parameters {return [:]}
    var headers: HTTPHeaders {return [:]}
    var baseUrlWithPath: String { return baseURL + path }
    var encoding: ParameterEncoding { JSONEncoding.default }
}






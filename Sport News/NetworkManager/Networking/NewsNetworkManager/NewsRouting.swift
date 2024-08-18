//
//  NewRouting.swift
//  Sport News
//
//  Created by Abdusalom on 04/08/2024.
//

import Foundation
import Alamofire

protocol NewsRouting {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var headers: HTTPHeaders { get }
    var baseUrlWithPath: String { get }
}

extension NewsRouting {
    var method: HTTPMethod {return .post}
    var parameters: Parameters {return [:]}
    var headers: HTTPHeaders {return [:]}
    var baseUrlWithPath: String { return baseURL + path }
}

//
//  API.swift
//  Sport News
//
//  Created by Abdusalom on 01/08/2024.
//

import Foundation

// Структура которая имеет одну статистическую функцую configure (выдает стринг)

struct API {
    
    static func configure(scheme: Scheme, domain: String, version: Version) -> String {
        return [Scheme.https.rawValue, domain, version.rawValue].joined(separator: "/")
    }
    
    
    //Enum для выбора схемы! Оставил только https
    enum Scheme: String {
        case https = "https:/"
    }
    
    
    // Version - для выбора версии 
    enum Version: String {
        case v1
    }
}

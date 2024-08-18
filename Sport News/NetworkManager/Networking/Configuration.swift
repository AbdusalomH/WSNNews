//
//  Configuration.swift
//  Sport News
//
//  Created by Abdusalom on 01/08/2024.
//

import Foundation

//структура будет хранить наши настройки здесь она хранит переменную с базовой ссылкой на api
struct Configuration {
    static let baseUrl = "api.sport-news24.com/api"
    static let WSNApi = KeychainManager.shared.getToken()
}


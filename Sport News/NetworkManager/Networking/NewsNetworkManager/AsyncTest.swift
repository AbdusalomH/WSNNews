//
//  AsyncTest.swift
//  Sport News
//
//  Created by Abdusalom on 18/08/2024.
//

import Foundation
import Alamofire



func getdata() async throws -> String {
    
    var sting = ""
  
    try await Task.sleep( nanoseconds: 2 * 1000000)
    sting = "tesk"

    return sting
    
}

func fetchAsync() async {
    
    do {
        let data = try await getdata()
        print(data)
    } catch {
        print(error)
    }  
}

actor Networking: GlobalActor {
    
    static let shared = Networking()
    
    private init() {}
    
    var header: HTTPHeaders = [
        "Authorization" : "123433"
    ]
    
    func getNews(pageIndex: Int, parametres: Parameters) async throws -> [NewsModel] {
        
        return try await withCheckedContinuation { receviedData in
            AF.request(baseUrl, method: .get, parameters: header)
        }
        
        
    }
  
}




//
//  NewsNetwork.swift
//  Sport News
//
//  Created by Abdusalom on 04/08/2024.
//

import Foundation


protocol GetNewsProtocol {
    
    typealias GetNewsCompletion<T> = (_ newsModel: T?, _ error: WSNErrors?) -> ()

    typealias GetNewsDetailsCompletion = (_ newsDetailsMode: NewsModelDetails?, _ error: WSNErrors?) -> ()
    
    typealias GetNewsCommentByID = (_ newsComment: [NewsCommentByIDModel]?, _ error: WSNErrors?) -> ()
    
    func getNews(index: Int, completion: @escaping GetNewsCompletion<[NewsModel]>)
    
    func getNewsDetails2(index: Int, completion: @escaping GetNewsCompletion<NewsModelDetails>)
    
    func getNewsDetails(id: Int, completion: @escaping GetNewsDetailsCompletion)
    
    func getNewsComment(id: Int, completion: @escaping GetNewsCommentByID)
}


class NewsNetworkManager: GetNewsProtocol {
    
    
    func getNewsDetails2(index: Int, completion: @escaping GetNewsCompletion<NewsModelDetails>) {
        
        NewsNetRouter<GetNewsEndpoint, NewsModelDetails>().newsRequest(.getNewsByID(id: index)) { response in
            
            switch response.result {
                
            case .success(let success):
                completion(success, nil)
            case .failure(let error):
                print(error)
                completion(nil, .invalidData)
            }
        }
    }
    
    
    func getNews(index: Int, completion: @escaping GetNewsCompletion<[NewsModel]>) {
        NewsNetRouter<GetNewsEndpoint, [NewsModel]>().newsRequest(.getNews(pageIndex: index)) { response in
            switch response.result {
            case .success(let success):
                
                completion(success, nil)
                
            case .failure(let error):
                
                print("Error here when fetch news\(error)")
                completion(nil, .invalidData)
//
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print(utf8Text)
                }
            }
        }
    }
    
    
    func getNewsComment(id: Int, completion: @escaping GetNewsCommentByID) {
        
        NewsNetRouter<GetNewsEndpoint, NewsCommentByIDModel>().newsRequest(.getNewsCommentByID(id: id)) { response in
            
            switch response.result {
                
            case .success(let success):
                completion([success], nil)
            case .failure(let error):
                print("problems with decoding")
                completion(nil, .invalidData)
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
            }
        }
    }
    
    
    
    func getNewsDetails(id: Int, completion: @escaping GetNewsDetailsCompletion) {
        
        
        NewsNetRouter<GetNewsEndpoint, NewsModelDetails>().newsRequest(.getNewsByID(id: id)) { response in
            
            switch response.result {
                
            case .success(let success):
                completion(success, nil)
            case .failure(let error):
                print(error)
                completion(nil, .invalidData)
            }
        }
    }
    

    
//    func getNews(index: Int, completion: @escaping GetNewsCompletion<[NewsModel]>) {
//        NewsNetRouter<GetNewsEndpoint, [NewsModel]>().newsRequest(.getNews(pageIndex: index)) { response in
//            switch response.result {
//            case .success(let success):
//                
//                completion(success, nil)
//                
//            case .failure(let error):
//                
//                print("Error here when fetch news\(error)")
//                completion(nil, .invalidData)
////                
//                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                    print(utf8Text)
//                }
//            }
//        }
//    }
}




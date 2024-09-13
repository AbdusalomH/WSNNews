//
//  FeedModelView.swift
//  Sport News
//
//  Created by Abdusalom on 31/08/2024.
//

import Foundation


class FeedModelView {
    
    let newsNetwork = NewsNetworkManager()
    
    var categoryData: [String] = []
    
    var groupedCategory: [String : [NewsModel]] = [:]
    
    var page = 1 {
        didSet {
            getNews(index: page)
        }
    }
    
    var hasMoreNews = true
    
    var firstLaunch = true
    
    
    
    func getNews(index: Int) {

        Task {
            if hasMoreNews {
                do {
                    let feedDetails = try await NewsNetworkManager().getFeed(index: page)
                    DispatchQueue.main.async {
                        for i in feedDetails {
                            
                            let title = i.source.title
                            
                            if var existed = self.groupedCategory[title] {
                                existed.append(i)
                                self.groupedCategory[title] = existed
                            } else {
                                self.groupedCategory[title] = [i]
                            }
                        }
                        NotificationCenter.default.post(name: .newsUpdated, object: nil)
                        if feedDetails.count < 100 {
                            self.hasMoreNews = false
                        }
                    }
                } catch {
                    print("something went wrong with async await")
                }
            }
        }
    }
}

extension Notification.Name {
    static let newsUpdated = Notification.Name("newsUpdated")
}

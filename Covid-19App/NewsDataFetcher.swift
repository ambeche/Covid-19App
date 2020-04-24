//
//  NewsDataFetcher.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 24.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import Foundation

class NewsDataFetcher {
    private var _url: URL?
    
    var mainScreen: NewsTableViewController?
    var url: String {
        set {
            _url = URL(string: newValue)
        }
        get {
            return _url?.absoluteString ?? "no url stored"
        }
    }
    
    func getNewsData () {

        let dataTask = URLSession.shared.dataTask(with: _url!) {
            data, response, error in if let error = error {
                print(error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            //print(data)
            do {
                let newsInfo = try JSONDecoder().decode(NewsDataStruct.self, from:data)
                print ("newsStatus", newsInfo.status)
                self.mainScreen?.saveNAs(newsArticles: newsInfo.articles)
            } catch let err {
                print("Error message", err)
            }
        }
            dataTask.resume()
    }
}

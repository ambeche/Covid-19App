//
//  Covid19API.swift
//  Covid-19App
//
//  Created by iosdev on 24.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import Foundation
class Covid19APPI {
    private var _url: URL?
    
    var url: String {
        set {
            _url = URL(string: newValue)
        }
        get {
            return _url?.absoluteString ?? "invalid url"
        }
    }
    
    func fetchStatistics () {

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
                print ("newsDataStatus", newsInfo.status)
                
            } catch let err {
                print("Error message", err)
            }
        }
            dataTask.resume()
    }
}

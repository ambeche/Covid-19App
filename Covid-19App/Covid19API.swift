//
//  Covid19API.swift
//  Covid-19App
//
//  Created by iosdev on 24.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//
//  Covid19APPI is the Model for HomeScreeenViewController, it fetches data from the server using dataTask() and uses HomeScreenViewController as a delegate.

import Foundation

class Covid19APPI {
    private var _url1: URL?
    private var _url2: URL?
    var covid19APIDelegate: Covid19APIDelegate?
    
    var url1: String {
        set {
            _url1 = URL(string: newValue)
        }
        get {
            return _url1?.absoluteString ?? "invalid url"
        }
    }
    
    var url2: String {
        set {
            _url2 = URL(string: newValue)
        }
        get {
            return _url2?.absoluteString ?? "invalid url"
        }
    }

// fetches the global statistics with country specific data
    func fetchStatistics() {

        let dataTask = URLSession.shared.dataTask(with: _url1!) {data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
        
            do {
                    let covid19Data = try JSONDecoder().decode(Covid19Data.self, from:data)
                    print ("count \(covid19Data.data.count)")
                    print (" names: \(covid19Data.data[0].name)")
                    
                    self.covid19APIDelegate?.fetchedData(covid19Data)
            } catch let err {
                print("Error message", err)
            }
        }
            dataTask.resume()
    }
      
// fetches the global timeline for Covid-19
    func fetchTimeline () {

        let dataTask = URLSession.shared.dataTask(with: _url2!) {data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
        
            do {
                
                let globalTimeline = try JSONDecoder().decode(GlobalTimeline.self, from:data)
                print ("count \(globalTimeline.data.count)")
                self.covid19APIDelegate?.fetchedGlobalTimeline(globalTimeline)
            } catch let err {
                print("Error message", err)
            }
        }
            dataTask.resume()
    }
}

protocol Covid19APIDelegate {
    func fetchedData (_ covid19Data: Covid19Data)
    func fetchedGlobalTimeline (_ GlobalTimeline: GlobalTimeline)
}

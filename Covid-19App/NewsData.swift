//
//  NewsData.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 24.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import Foundation

struct NewsDataStruct:Codable {
    var status: String
    var totalResults: Int
    var articles: [NewsArticleStruct]
}

struct NewsArticleStruct: Codable {
    var source: [String : String?]
    var author: String?
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String?
}

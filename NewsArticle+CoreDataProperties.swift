//
//  NewsArticle+CoreDataProperties.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 24.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//
//

import Foundation
import CoreData


extension NewsArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsArticle> {
        return NSFetchRequest<NewsArticle>(entityName: "NewsArticle")
    }

    @NSManaged public var desc: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlIm: String?

}

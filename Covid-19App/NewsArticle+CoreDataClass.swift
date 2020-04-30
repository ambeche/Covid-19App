//
//  NewsArticle+CoreDataClass.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 29.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//
//

import Foundation
import CoreData


public class NewsArticle: NSManagedObject {
    class func getOrCreateNewsArticleWith (title: String, context: NSManagedObjectContext) throws -> NewsArticle {
        let request:NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", title)
        
        do {
            let matchingNewsArticles = try context.fetch(request)
            if matchingNewsArticles.count == 0 {
                //print("new newsArticle ns object created")
                let newNewsArticle = NewsArticle (context: context)
                return newNewsArticle
            } else if matchingNewsArticles.count == 1 {
                //print("newsArticle already exist")
                return matchingNewsArticles[0]
            } else {
                print("Database inconsistent found same news articles")
                return matchingNewsArticles[0]
            }
        } catch {
            throw error
        }
    }

}

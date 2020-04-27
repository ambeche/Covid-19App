//
//  NewsTableViewController.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 24.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit
import CoreData

class NewsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var newsNavBar: UINavigationItem!
    
    @IBOutlet var newsTableView: UITableView!
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let urlToFetch: String = "https://newsapi.org/v2/everything?q=corona&apiKey=6983b2459a5a4e0a8c106285b934ba53"
    let newsDF = NewsDataFetcher()
    var fetchedResultsController:NSFetchedResultsController<NewsArticle>?

    override func viewDidLoad() {
        super.viewDidLoad()
        newsDF.mainScreen = self
        newsDF.url = self.urlToFetch
        newsDF.getNewsData()
        fetchNAs()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // to save newsArticles in context
    func saveNAs(newsArticles: [NewsArticleStruct]) {
        print("saveNAs function call")
        viewContext.perform {
            do {
            for newsA in newsArticles {
                let newsAToAdd = try NewsArticle.getOrCreateNewsArticleWith(title: newsA.title, context: self.viewContext)
                newsAToAdd.title = newsA.title
                newsAToAdd.desc = newsA.description
                newsAToAdd.url = newsA.url
                newsAToAdd.urlIm = newsA.urlToImage
            }
                try self.viewContext.save()
                print("saved successfully")
            } catch let error as NSError {
                print("Could not save. \(error). \(error.userInfo)")
            }
        }
    }
    
    func fetchNAs(){
        let fetchRequest:NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: "title", cacheName: "newsArticlesCache")
            fetchedResultsController?.delegate = self as NSFetchedResultsControllerDelegate
            try fetchedResultsController?.performFetch()
        } catch let error as NSError{
            print("Could not fetch. \(error). \(error.userInfo)")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controllerDidChangeContent")
        self.newsTableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController!.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sections = fetchedResultsController!.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("The dequeued cell is not an instance of PersonTableViewCell")
        }

        // Configure the cell...
        guard let newsItem = self.fetchedResultsController?.object(at: indexPath) else {
            fatalError("news item not found from fetched results controller")
        }
        // Configure the cell...
        cell.newsTitle.text = newsItem.title
        cell.newsDescription.text = newsItem.desc
        cell.setImage(from: newsItem.urlIm ?? "no image selected")
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromNewsCellToWebView") {
            guard let newsWebViewController = segue.destination as? WebViewController else {
               fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedNewsCell = sender as? NewsTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedNewsCell) else {
                fatalError("The selected cell is not bieng displayed by the table")
            }
            
            guard let newsItem = self.fetchedResultsController?.object(at: indexPath) else {
                       fatalError("news item not found from fetched results controller")
                   }
            newsWebViewController.urlToLoad = newsItem.url
        }
    }
}

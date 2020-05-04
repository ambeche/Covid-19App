//
//  StatisticsTableViewController.swift
//  Covid-19App
//
//  Created by iosdev on 24.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class StatisticsTableViewController: UITableViewController, UISearchResultsUpdating, Covid19APIDelegate {
    
    
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
    }
    
    @IBOutlet weak var gRecoverd: UILabel!
    
    @IBOutlet weak var gDeaths: UILabel!
    
    @IBOutlet weak var gConfirmed: UILabel!
    
    @IBOutlet weak var gCritical: UILabel!
    
    
    let apiUrl = "https://corona-api.com/countries?include=timeline"
    var covid19Fetcher = Covid19APPI()
    private var covidStatistics = [Country]()
    private var isloading = true
    private var filteredCovidStatistics = [Country]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var checkSearchBarContent: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = false
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        covid19Fetcher.url1 = apiUrl
        covid19Fetcher.covid19APIDelegate = self
        covid19Fetcher.fetchStatistics()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Country or city"
        searchController.searchBar.backgroundColor = UIColor.systemBackground
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isloading {
            if isfiltering() {
                       return filteredCovidStatistics.count
                   }
                   return covidStatistics.count
        }
        
        return 1
    }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsTableViewCell", for: indexPath) as? StatisticsTableViewCell  else {
        fatalError("invalid cell type.")
    }
    
    var stats: Country
    if !isloading {
        if isfiltering(){
               stats = filteredCovidStatistics[indexPath.row]
           }
           else {
               stats = covidStatistics[indexPath.row]
           }
        cell.countryName.text = stats.name
        cell.recovered.text = "\(stats.latest_data.recovered)"
        cell.fatalities.text = "\(stats.latest_data.deaths)"
        cell.infected.text = "\(stats.latest_data.confirmed)"
    }
    else {
        cell.countryName.text = "loading"
    }
    
    return cell
    
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
           print("america")
   }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterDataBySearchText(searchController.searchBar.text ?? "")
        
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard
        segue.identifier == "ShowCountryDetails",
        let indexPath = tableView.indexPathForSelectedRow,
        let countryDetailsViewController = segue.destination as? CountryDetailsViewController
        else {
          return
      }
      
        var stats: Country
      if isfiltering(){
             stats = filteredCovidStatistics[indexPath.row]
         }
         else {
             stats = covidStatistics[indexPath.row]
         }
      
      countryDetailsViewController.stats = stats
    }
    
    func isfiltering() -> Bool {
        return searchController.isActive && !checkSearchBarContent
    }
    
    func filterDataBySearchText (_ searchText: String){
        filteredCovidStatistics = covidStatistics.filter{ data -> Bool in
            return data.name.lowercased().contains(searchText.lowercased())
        }
      
        tableView.reloadData()
    }

    func fetchedData(_ covid19Data: Covid19Data) {
        DispatchQueue.main.async {
            self.covidStatistics = covid19Data.data
            self.isloading = false
            self.tableView.reloadData()
            print("\(covid19Data.globalCritical )")
        }
    }
    
    func fetchedGlobalTimeline(_ GlobalTimeline: GlobalTimeline) {
        
    }
}

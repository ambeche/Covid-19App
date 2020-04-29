//
//  HomeScreenViewController.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 29.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, Covid19APIDelegate {
    
   @IBOutlet weak var gRecoverd: UILabel!
    
    @IBOutlet weak var gDeaths: UILabel!
    
    @IBOutlet weak var gConfirmed: UILabel!
    
    @IBOutlet weak var gCritical: UILabel!
    
    let apiUrl = "https://corona-api.com/countries"
    var covid19Fetcher = Covid19APPI()
    private var covidStatistics = [Country]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        covid19Fetcher.url = apiUrl
        covid19Fetcher.covid19APIDelegate = self
        covid19Fetcher.fetchStatistics()
    }
    
    func fetchedData(_ covid19Data: Covid19Data) {
        DispatchQueue.main.async {
            self.covidStatistics = covid19Data.data
            self.gDeaths.text = "\(covid19Data.globalDeaths)"
            self.gConfirmed.text = "\(covid19Data.globalConfirmed)"
            self.gCritical.text = "\(covid19Data.globalCritical )"
            self.gRecoverd.text  = "\(covid19Data.globalRecovered)"
            print("critical \(covid19Data.globalCritical ) recovered \(covid19Data.globalRecovered)  confirmed  \(covid19Data.globalConfirmed) deaths  \(covid19Data.globalDeaths)")
        }
    }
    
}

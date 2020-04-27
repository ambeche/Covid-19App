//
//  CountryDetailsViewController.swift
//  Covid-19App
//
//  Created by iosdev on 27.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    var stats: Country?
    
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var critical: UILabel!
    
    @IBOutlet weak var recovered: UILabel!
    
    @IBOutlet weak var deaths: UILabel!
    
    @IBOutlet weak var confirmed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showCountryDetails()
        
    }
    
    
    func showCountryDetails() {
        
      if let stats = stats,
        let countryName = countryName,
        let critical = critical,
        let recovered = recovered,
        let deaths = deaths,
        let confirmed = confirmed {
        countryName.text = stats.name
        critical.text = "\(stats.latest_data.critical ?? 0)"
        recovered.text = "\(stats.latest_data.recovered)"
        deaths.text = "\(stats.latest_data.deaths)"
        confirmed.text = "\(stats.latest_data.confirmed)"
      }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

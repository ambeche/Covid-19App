//
//  RecSymptomsTableViewController.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 29.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class RecSymptomsTableViewController: UITableViewController {
        let statusArray: Array<String> = ["Healthy", "Quarantined", "Covid-19 +", "Recovered"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "symtomTableViewCell", for: indexPath) as? RecSymptomsTableViewCell else{
            fatalError("The dequeued cell is not an instance of RecSymptomsTableViewCell")
        }
        
        //Date text label config
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 20, y: 11, width: 374, height: 21)
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_US")
        dateLabel.text = formatter.string(from: currentDate)
        dateLabel.textAlignment = NSTextAlignment.center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.symptomContentView.addSubview(dateLabel)
        
        //Fever text label config
        let feverLabel = UILabel()
        feverLabel.frame = CGRect(x: 20, y: 37, width: 374, height: 21)
        feverLabel.text = "🤒 Fever"
        cell.symptomContentView.addSubview(feverLabel)
        
        //Cough text label config
        let coughLabel = UILabel()
        coughLabel.frame = CGRect(x: 20, y: 60, width: 374, height: 21)
        coughLabel.text = "😷 Cough"
        cell.symptomContentView.addSubview(coughLabel)
        
        //Breathing Difficulties text label config
        let breathDiffLabel = UILabel()
        breathDiffLabel.frame = CGRect(x: 20, y: 83, width: 374, height: 21)
        breathDiffLabel.text = "🤢 Breathing Difficulties"
        cell.symptomContentView.addSubview(breathDiffLabel)
        
        //Muscle Pain text label config
        let musclePainLabel = UILabel()
        musclePainLabel.frame = CGRect(x: 20, y: 106, width: 374, height: 21)
        musclePainLabel.text = "🥵 Muscle Pain"
        cell.symptomContentView.addSubview(musclePainLabel)
        
        //Sore Throat text label config
        let soreThroatLabel = UILabel()
        soreThroatLabel.frame = CGRect(x: 20, y: 129, width: 374, height: 21)
        soreThroatLabel.text = "🤧 Sore Throat"
        cell.symptomContentView.addSubview(soreThroatLabel)
        
        //Chills text label config
        let chillsLabel = UILabel()
        chillsLabel.frame = CGRect(x: 20, y: 152, width: 374, height: 21)
        chillsLabel.text = "🥶 Chills"
        cell.symptomContentView.addSubview(chillsLabel)
        
        
        //Headache text label config
        let headacheLabel = UILabel()
        headacheLabel.frame = CGRect(x: 20, y: 175, width: 374, height: 21)
        headacheLabel.text = "🤕 Headache"
        cell.symptomContentView.addSubview(headacheLabel)
        
        //Loss of Taste or Smell
        let lossOfTasSmellLabel = UILabel()
        lossOfTasSmellLabel.frame = CGRect(x: 20, y: 198, width: 374, height: 21)
        lossOfTasSmellLabel.text = "🤮 Loss of Taste or Smell"
        cell.symptomContentView.addSubview(lossOfTasSmellLabel)
        
        
        // Configure the cell...
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

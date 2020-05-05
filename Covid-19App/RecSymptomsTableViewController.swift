//
//  RecSymptomsTableViewController.swift
//  Covid-19App
//  Class created for displaying recorded symptoms of logged in user (rafei)
//  Created by Rafe Ibrahim on 29.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit
import CoreData
import Charts

class RecSymptomsTableViewController: UITableViewController {
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let statusArray: Array<String> = ["Healthy", "Quarantined", "Covid-19 +", "Recovered"]
    var user: User?
    var symptomArray: Array<Symptom>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        let covidDefaults = UserDefaults.standard
        if (covidDefaults.string(forKey: "loggedInUser") == nil) {
        pushToLoginScreen()
        } else {
            guard let loggedInUserEmail = covidDefaults.string(forKey: "loggedInUser") else {
                return
            }
            do {
                //self.user = try User.fetchUserByEmail(email: loggedInUserEmail, context: self.viewContext)
                self.symptomArray = try User.fetchAllSymptomsForUser(email: loggedInUserEmail, context: viewContext)
                
            } catch let error as NSError {
                print("Could not fetch symptoms for user. \(error). \(error.userInfo)")
            }
        }
    }
    
    func pushToLoginScreen () {
        print("pushToLoginScreen called")
        let storyBoard: UIStoryboard = UIStoryboard(name: "auth", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "authVC") as! LoginViewController
                //self.present(newViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.symptomArray!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "symtomTableViewCell", for: indexPath) as? RecSymptomsTableViewCell else{
            fatalError("The dequeued cell is not an instance of RecSymptomsTableViewCell")
        }
        guard let targetSymptom = self.symptomArray?[indexPath.row] else {
            fatalError("symptom not found in fetched results")
        }
        var yCord = 37
        // Configure the cell...
        //Date text label config
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 20, y: 11, width: 374, height: 21)
        let currentDate = targetSymptom.date!
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_US")
        dateLabel.text = formatter.string(from: currentDate)
        dateLabel.textAlignment = NSTextAlignment.center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.symptomContentView.addSubview(dateLabel)
        
        //Fever text label config
        if (targetSymptom.fever) {
            let feverLabel = UILabel()
            feverLabel.frame = CGRect(x: 20, y: yCord, width: 374, height: 21)
            feverLabel.text = "🤒 Fever"
            cell.symptomContentView.addSubview(feverLabel)
            yCord += 23
        }
        
        //Cough text label config
        if (targetSymptom.cough) {
            let coughLabel = UILabel()
            coughLabel.frame = CGRect(x: 20, y: yCord, width: 374, height: 21)
            coughLabel.text = "😷 Cough"
            cell.symptomContentView.addSubview(coughLabel)
            yCord += 23
        }
        
        //Breathing Difficulties text label config
        if (targetSymptom.breathing) {
            let breathDiffLabel = UILabel()
            breathDiffLabel.frame = CGRect(x: 20, y: yCord, width: 374, height: 21)
            breathDiffLabel.text = "🤢 Breathing Difficulties"
            cell.symptomContentView.addSubview(breathDiffLabel)
            yCord += 23
        }
        
        //Muscle Pain text label config
        if (targetSymptom.muscle) {
            let musclePainLabel = UILabel()
            musclePainLabel.frame = CGRect(x: 20, y: yCord, width: 374, height: 21)
            musclePainLabel.text = "🥵 Muscle Pain"
            cell.symptomContentView.addSubview(musclePainLabel)
            yCord += 23
        }
        
        //Sore Throat text label config
        if (targetSymptom.throat) {
            let soreThroatLabel = UILabel()
            soreThroatLabel.frame = CGRect(x: 20, y: yCord, width: 374, height: 21)
            soreThroatLabel.text = "🤧 Sore Throat"
            cell.symptomContentView.addSubview(soreThroatLabel)
            yCord += 23
        }
        
        //Chills text label config
        if (targetSymptom.chills) {
            let chillsLabel = UILabel()
            chillsLabel.frame = CGRect(x: 20, y: yCord, width: 374, height: 21)
            chillsLabel.text = "🥶 Chills"
            cell.symptomContentView.addSubview(chillsLabel)
            yCord += 23
        }
        
        //Headache text label config
        if (targetSymptom.headache) {
            let headacheLabel = UILabel()
            headacheLabel.frame = CGRect(x: 20, y: yCord, width: 374, height: 21)
            headacheLabel.text = "🤕 Headache"
            cell.symptomContentView.addSubview(headacheLabel)
            yCord += 23
        }
        
        //Loss of Taste or Smell
        if (targetSymptom.taste) {
            let lossOfTasSmellLabel = UILabel()
            lossOfTasSmellLabel.frame = CGRect(x: 20, y: yCord, width: 374, height: 21)
            lossOfTasSmellLabel.text = "🤮 Loss of Taste or Smell"
            cell.symptomContentView.addSubview(lossOfTasSmellLabel)
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 40
        guard let targetSymptom = self.symptomArray?[indexPath.row] else {
            fatalError("symptom not found in fetched results")
        }
        if (targetSymptom.fever) {height += 25}
        if (targetSymptom.cough) {height += 25}
        if (targetSymptom.breathing) {height += 25}
        if (targetSymptom.muscle) {height += 25}
        if (targetSymptom.throat) {height += 25}
        if (targetSymptom.chills) {height += 25}
        if (targetSymptom.headache) {height += 25}
        if (targetSymptom.taste) {height += 25}
        
        return height
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

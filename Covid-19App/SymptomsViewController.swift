//
//  SymptomsViewController.swift
//  Covid-19App
//
//  Created by iosdev on 29.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class SymptomsViewController: UIViewController {
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var feverSwitch: UISwitch!
    @IBOutlet weak var coughSwitch: UISwitch!
    @IBOutlet weak var breathDiffSwitch: UISwitch!
    @IBOutlet weak var musclePainSwitch: UISwitch!
    @IBOutlet weak var soreThroatSwitch: UISwitch!
    @IBOutlet weak var chillsSwitch: UISwitch!
    @IBOutlet weak var headacheSwitch: UISwitch!
    @IBOutlet weak var lossTasteSmellSwitch: UISwitch!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let covidDefaults = UserDefaults.standard
        if (covidDefaults.string(forKey: "loggedInUser") == nil) {
        pushToLoginScreen()
        } else {
            guard let loggedInUserEmail = covidDefaults.string(forKey: "loggedInUser") else {
                return
            }
            do {
                self.user = try User.fetchUserByEmail(email: loggedInUserEmail, context: self.viewContext)
                
            } catch let error as NSError {
                print("Could not fetch user with email. \(error). \(error.userInfo)")
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
    
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
            if let targetUser = self.user {
                let symptomRecordToAdd = Symptom(context: self.viewContext)
                symptomRecordToAdd.date = Date()
                symptomRecordToAdd.fever = self.feverSwitch.isOn
                symptomRecordToAdd.cough = self.coughSwitch.isOn
                symptomRecordToAdd.breathing = self.breathDiffSwitch.isOn
                symptomRecordToAdd.muscle = self.musclePainSwitch.isOn
                symptomRecordToAdd.throat = self.soreThroatSwitch.isOn
                symptomRecordToAdd.chills = self.coughSwitch.isOn
                symptomRecordToAdd.headache = self.headacheSwitch.isOn
                symptomRecordToAdd.taste = self.lossTasteSmellSwitch.isOn
                //adding test string for testing
                symptomRecordToAdd.time = "testTime"
                symptomRecordToAdd.symptomBelongToUser = targetUser
                do {
                    try viewContext.save()
                    self.performSegue(withIdentifier: "FromSymptomsScreenToProfileScreen", sender: nil)
                } catch let error as NSError {
                    print("Could not save symptom record to user. \(error). \(error.userInfo)")
                }
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


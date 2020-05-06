//
//  ChangeStatusViewController.swift
//  Covid-19App
//  Screen with pickerView to allow logged in user to change his / her status (rafei)
//  Created by Rafe Ibrahim on 2.5.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class ChangeStatusViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var statusColorLabel: UILabel!
    @IBOutlet weak var currentStatusLabel: UILabel!
    @IBOutlet weak var statusPickerView: UIPickerView!
    let statusArray: Array<String> = [NSLocalizedString("Healthy", comment: "statusArray value healthy"),NSLocalizedString("Quarantined", comment: "statusArray value quarantined"), NSLocalizedString("Covid-19 +", comment: "statusArray value covid19"), NSLocalizedString("Recovered", comment: "statusArray value recovered")];
    
    var statusToBeSaved: String = NSLocalizedString("Healthy", comment: "healthy");
    var currentUser: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusPickerView.dataSource = self
        self.statusPickerView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let covidDefaults = UserDefaults.standard
        if (covidDefaults.string(forKey: "loggedInUser") == nil) {
        // pushToLoginScreen()
        } else {
            guard let loggedInUserEmail = covidDefaults.string(forKey: "loggedInUser") else {
                return
            }
            do {
                let loggedInUser = try User.fetchUserByEmail(email: loggedInUserEmail, context: self.viewContext)
                self.currentUser = loggedInUser
                self.currentStatusLabel.text = loggedInUser.status
                if loggedInUser.status == NSLocalizedString("Healthy", comment: "healthy") {
                    self.statusColorLabel.backgroundColor = UIColor.blue
                } else if loggedInUser.status == NSLocalizedString("Quarantined", comment: "quarantined") {
                    self.statusColorLabel.backgroundColor = UIColor.orange
                } else if loggedInUser.status == NSLocalizedString("Covid-19 +", comment: "covid19") {
                    self.statusColorLabel.backgroundColor = UIColor.red
                } else {
                    self.statusColorLabel.backgroundColor = UIColor.green
                }
            } catch let error as NSError {
                print("Could not fetch user with email. \(error). \(error.userInfo)")
            }
        }
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statusArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("status slected: \(self.statusArray[row])")
        self.statusToBeSaved = self.statusArray[row]
    }
    
    
    @IBAction func saveStatusBtnPressed(_ sender: UIButton) {
        print("status to be saved: \(self.statusToBeSaved)")
        if let user = self.currentUser {
            do {
                user.status = self.statusToBeSaved
                try self.viewContext.save()
                self.currentStatusLabel.text = user.status
                if user.status == NSLocalizedString("Healthy", comment: "") {
                    self.statusColorLabel.backgroundColor = UIColor.blue
                } else if user.status == NSLocalizedString("Quarantined", comment: ""){
                    self.statusColorLabel.backgroundColor = UIColor.orange
                } else if user.status == NSLocalizedString("Covid-19 +" , comment: ""){
                    self.statusColorLabel.backgroundColor = UIColor.red
                } else {
                    self.statusColorLabel.backgroundColor = UIColor.green
                }
            } catch let error as NSError {
                print("Could not save status in context. \(error). \(error.userInfo)")
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

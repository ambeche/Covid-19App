//
//  RegisterViewController.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 30.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var nameRegister: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func saveUserData() {
        print("saveUserData to function called")
        do {
            if (try !User.checkUserExists(email: emailRegister.text ?? "", context: self.viewContext)) {
                let newUser = User(context: self.viewContext)
                newUser.name = nameRegister.text
                newUser.email = emailRegister.text
                newUser.password = passwordRegister.text
                // saving default status i.e. healthy
                newUser.status = "Healthy"
                // adding symptoms here for testing purposes
                let symptom1 = Symptom(context: self.viewContext)
                symptom1.time = "number1"
                symptom1.symptomBelongToUser = newUser
                let symptom2 = Symptom(context: self.viewContext)
                symptom2.time = "number2"
                symptom2.symptomBelongToUser = newUser
            }
            try viewContext.save()
            print ("user saved successfully")
            // seeting up userDefault key for loggedInUser
            let covidDefaults = UserDefaults.standard
            covidDefaults.set(nameRegister.text, forKey: "loggedInUser")
            try User.fetchAllUsers(context: self.viewContext)
            //retrieving symptoms here for testing purposes
            try User.fetchAllSymptomsForUser(email: emailRegister.text!, context: self.viewContext)
        } catch let error as NSError {
            print("Could not save. \(error). \(error.userInfo)")
        }
    }
    

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        saveUserData()
//        self.performSegue(withIdentifier: "BackToProfileScreenFromRegisterScreen", sender: nil)
    }
    
    // created for future functionalities like authentication
    @IBAction func registerNameDidEndEditing(_ sender: UITextField) {
    }
    @IBAction func registerEmailDidEndEditing(_ sender: UITextField) {
    }
    @IBAction func registerPasswordDidEndEditing(_ sender: UITextField) {
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

//
//  RegisterViewController.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 30.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController, UITextFieldDelegate {
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var nameRegister: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
    @IBOutlet weak var fullNameErrorText: UILabel!
    @IBOutlet weak var emailErrorText: UILabel!
    @IBOutlet weak var passwordErrorText: UILabel!
    @IBOutlet weak var confirmPasswordRegister: UITextField!
    @IBOutlet weak var registerBtnErrorText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordRegister.isSecureTextEntry = true
        self.confirmPasswordRegister.isSecureTextEntry = true
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
            }
            try viewContext.save()
            print ("user saved successfully")
            // setting up userDefault key for loggedInUser
            let covidDefaults = UserDefaults.standard
            covidDefaults.set(emailRegister.text, forKey: "loggedInUser")
            //line for fetching users for testing purposes
            //try User.fetchAllUsers(context: self.viewContext)
            //retrieving symptoms here for testing purposes
            //try User.fetchAllSymptomsForUser(email: emailRegister.text!, context: self.viewContext)
        } catch let error as NSError {
            print("Could not save. \(error). \(error.userInfo)")
        }
    }
    

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        //Authentication Tests
        let nameValid = self.isFullNameValid(fullName: self.nameRegister.text!)
        let emailValid = self.isEmailValid(email: self.emailRegister.text!)
        let passwordValid = self.isPasswordValid(password: self.passwordRegister.text!)
        if (nameValid && emailValid && passwordValid){
            saveUserData()
            self.performSegue(withIdentifier: "BackToProfileScreenFromRegisterScreen", sender: nil)
            self.registerBtnErrorText.text = ""
        } else {
            self.registerBtnErrorText.text = "One or more fields require your attention"
        }
    }
    
    func isEmailValid(email: String) -> Bool {
        //check if email is valid
        do {
            let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
            let validEmail = testEmail.evaluate(with: email)
            if (!validEmail) {
                self.emailErrorText.text = "Email Format Not Correct"
                return false
            }
            let emailAvailable = try !User.checkUserExists(email: emailRegister.text ?? "", context: self.viewContext)
            if (!emailAvailable) {
                self.emailErrorText.text = "Email already registered"
                return false
            }
            self.emailErrorText.text = ""
            return true
            
        } catch let error as NSError {
            print("Could not check email avaialability. \(error). \(error.userInfo)")
            self.emailErrorText.text = "Email availability could not be checked"
            return false
        }
    }
    
    func isFullNameValid(fullName: String) -> Bool {
        if (fullName.count > 3) {
            self.fullNameErrorText.text = ""
            return true
        }
        self.fullNameErrorText.text = "Full name must be greater than 3 characters"
        return false
    }
    
    func isPasswordValid(password: String) -> Bool {
        if (password.count <= 5) {
            self.passwordErrorText.text = "Password length must be greater than 5"
            return false
        }
        if (self.passwordRegister.text != self.confirmPasswordRegister.text){
            self.passwordErrorText.text = "Passwords do not match"
            return false
        }
        self.passwordErrorText.text = ""
        return true
    }
    
    // created for future functionalities like authentication
    
    @IBAction func nameDidEndEditing(_ sender: UITextField) {
        self.isFullNameValid(fullName: self.nameRegister.text!)
    }
    
    @IBAction func registerEmailDidEndEditing(_ sender: UITextField) {
        self.isEmailValid(email: emailRegister.text!)
    }
    
    @IBAction func registerPasswordDidEndEditing(_ sender: UITextField) {
        self.isPasswordValid(password: self.passwordRegister.text!)
    }
    
    
    @IBAction func confirmPasswordDidEndEditing(_ sender: UITextField) {
            self.isPasswordValid(password: self.passwordRegister.text!)
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

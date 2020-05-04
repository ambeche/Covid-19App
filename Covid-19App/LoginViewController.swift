//
//  LoginViewController.swift
//  Covid-19App
//  Typical login screen for logging in registered users (rafei)
//  Created by Rafe Ibrahim on 28.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtnErrorText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.passwordTextField.isSecureTextEntry = true
    }
    

    @IBAction func emailEditingDidEnd(_ sender: UITextField) {
        print("\(emailTextField.text ?? "no username")")
    }
    
    @IBAction func passwordEditingDidEnd(_ sender: UITextField) {
                print("\(passwordTextField.text ?? "no password")")
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        do {
           let emailExists = try User.checkUserExists(email: emailTextField.text ?? "", context: self.viewContext)
            if (emailExists) {
                let targetUser = try User.fetchUserByEmail(email: emailTextField.text!, context: self.viewContext)
                if (targetUser.password == passwordTextField.text!) {
                    //successful login
                    self.loginBtnErrorText.text = ""
                    let covidDefaults = UserDefaults.standard
                    covidDefaults.set(emailTextField.text!, forKey: "loggedInUser")
                    self.performSegue(withIdentifier: "BackToProfileScreen", sender: nil)
                } else {
                    self.loginBtnErrorText.text = "Wrong username or password"
                }
                
            } else {
                self.loginBtnErrorText.text = "Wrong username or password"
            }
        } catch let error as NSError {
            print("Could not verify login details. \(error). \(error.userInfo)")
            self.loginBtnErrorText.text = "Could not verify login details"
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

//
//  LoginViewController.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 28.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func emailEditingDidEnd(_ sender: UITextField) {
        print("\(emailTextField.text ?? "no username")")
    }
    
    @IBAction func passwordEditingDidEnd(_ sender: UITextField) {
                print("\(passwordTextField.text ?? "no password")")
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let covidDefaults = UserDefaults.standard
        covidDefaults.set("rafe", forKey: "user")
        self.performSegue(withIdentifier: "BackToProfileScreen", sender: nil)
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

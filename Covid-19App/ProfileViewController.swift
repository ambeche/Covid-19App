//
//  ProfileViewController.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 28.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var logoutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let covidDefaults = UserDefaults.standard
        if (covidDefaults.string(forKey: "user") == nil) {
            pushToLoginScreen()
        }
    }
    
    @IBAction func unwindToProfileScreen (unwindSegue: UIStoryboardSegue) {
        print("unwinding from \(unwindSegue.destination)")
    }
    
    func pushToLoginScreen () {
        print("pushToLoginScreen called")
        let storyBoard: UIStoryboard = UIStoryboard(name: "auth", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "authVC") as! LoginViewController
                //self.present(newViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        let covidDefaults = UserDefaults.standard
        covidDefaults.removeObject(forKey: "user")
        pushToLoginScreen()
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

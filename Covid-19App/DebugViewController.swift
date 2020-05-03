//
//  DebugViewController.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 3.5.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class DebugViewController: UIViewController {
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteAllUsersBtnPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete All Users", message: "Are you sure", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: {action in
            do {
                try User.deleteAllUsers(context: self.viewContext)
                let covidDefaults = UserDefaults.standard
                covidDefaults.removeObject(forKey: "loggedInUser")
            }catch let error as NSError {
                print("Could not delete. \(error). \(error.userInfo)")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
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

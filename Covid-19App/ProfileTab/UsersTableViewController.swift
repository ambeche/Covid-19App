//
//  UsersTableViewController.swift
//  Covid-19App
//  Class created for displaying registered users in a table view. (rafei)
//  Created by Rafe Ibrahim on 3.5.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userArray: Array<User>?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //covidDefaults.set(emailTextField.text!, forKey: "loggedInUser")
        let covidDefaults = UserDefaults.standard
        if (covidDefaults.string(forKey: "loggedInUser") == nil) {
            print("first break point")
        pushToLoginScreen()
        } else {
            guard covidDefaults.string(forKey: "loggedInUser") != nil else {
                return
            }
            do {
                self.userArray = try User.fetchAllUsers(context: self.viewContext)
                
            } catch let error as NSError {
                print("Could not fetch list of users. \(error). \(error.userInfo)")
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.userArray!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTabelCell", for: indexPath) as? UsersTableViewCell else{
            fatalError("The dequeued cell is not an instance of UsersTableViewCell")
        }
        
        guard let targetUser = self.userArray?[indexPath.row] else {
            fatalError("user not found in fetched results")
        }
        print("targetUseremail", targetUser.email ?? "no email")
        cell.userNameLabel.text = targetUser.name
        cell.userEmailLabel.text = targetUser.email
        cell.userStatusLabel.text = targetUser.status
        if targetUser.status == "Healthy" {
            cell.statusColorLabel.backgroundColor = UIColor.blue
         } else if targetUser.status == "Quarantined" {
             cell.statusColorLabel.backgroundColor = UIColor.orange
         } else if targetUser.status == "Covid-19 +" {
             cell.statusColorLabel.backgroundColor = UIColor.red
         } else {
             cell.statusColorLabel.backgroundColor = UIColor.green
         }
        return cell
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

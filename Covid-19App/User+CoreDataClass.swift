//
//  User+CoreDataClass.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 29.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//
//

import Foundation
import CoreData


public class User: NSManagedObject {
    class func checkUserExists (email: String, context: NSManagedObjectContext) throws -> Bool {
        print("email existence checked for email, \(email)")
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email = %@", email)
        do {
            let matchingUsers = try context.fetch(request)
            if matchingUsers.count == 0 {
                print("No user exists with this email address")
                return false
            } else if matchingUsers.count == 1 {
                print("User already exists with this email address")
                return true
            } else {
                print ("Database inconsistent found similar users")
                //it must also throw error
                return true
            }
        } catch {
            throw error
        }
    }
    
    class func fetchUserByEmail (email: String, context: NSManagedObjectContext) throws -> User {
        print("user fetched with Email, \(email)")
        let userRequestByEmail: NSFetchRequest = User.fetchRequest()
        userRequestByEmail.predicate = NSPredicate(format: "email = %@", email)
        do {
            let matchingUsers = try context.fetch(userRequestByEmail)
            return matchingUsers[0]
        } catch {
            throw error
        }
    }
    
    class func fetchAllUsers (context: NSManagedObjectContext) throws -> Array<User> {
        let usersRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = try context.fetch(usersRequest)
        for user in users {
            print ("user email \(user.email ?? "no email found")")
        }
        return users
    }
    
    class func deleteAllUsers (context: NSManagedObjectContext) throws {
        let usersRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = try context.fetch(usersRequest)
        for user in users {
            print ("deleting user \(user.email ?? "no email found")")
            context.delete(user)
        }
        try context.save()
    }
    
    class func fetchAllSymptomsForUser (email: String, context: NSManagedObjectContext) throws -> Array<Symptom> {
        do {
            let targetObject = try fetchUserByEmail(email: email, context: context)
            if let symptomSet = targetObject.userHasSymptoms as? Set<Symptom>{
                for symptom in symptomSet {
                    print("Symptom Record")
                    print("\(symptom.time ?? "no time string found")")
                    if let date = symptom.date {
                        print("date: \(date)")
                    }
                    //print(" date: \(symptom.date ?? Date(timeIntervalSinceReferenceDate: 0))")
                    if symptom.fever {
                        print("fever recorded")
                    }
                }
                var symptomArray = Array(symptomSet)
                symptomArray = symptomArray.sorted(by: {
                    $0.date!.compare($1.date!) == .orderedDescending
                })
                return symptomArray
            }
            let emptySymptomSet: Set<Symptom> = []
            return Array(emptySymptomSet)
        } catch {
            throw error
        }
    }
}

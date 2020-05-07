//
//  Person.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 4.5.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import Foundation
import UIKit

class Person {
    let minHeight = 100
    let maxHeight = 200
    let minWeight = 30
    let maxWeight = 200
    let minAge = 18
    let maxAge = 100
    
    private(set) var name: String
    private(set) var email: String
    private(set) var password: String
    private(set) var status: String
    private(set) var height: Int?
    private(set) var weight: Int?
    private(set) var age: Int?
    private(set) var professionSet = Set<String>() // should have 3 - 5 separate values
    private(set) var symptomArray = Array<String>()
    
    var BMI:Double {
        get {
            guard let height = self.height else {
                return 0
            }
            guard let weight = self.weight else {
                return 0
            }
                let heightInMeters = Double(height)/100.0
                return Double(weight)/(heightInMeters * heightInMeters)
        }
    }
    
    init? (name: String, email: String, password: String, status: String) {
        // The name must not be empty or less than 3 characters
        guard !name.isEmpty && name.count > 2 else {
            return nil
        }
        
        // The email cannot be empty
        guard !email.isEmpty else {
            return nil
        }
        
        // The password must not be empty or less than 3 characters
        guard !password.isEmpty && password.count > 4 else {
            return nil
        }
        
        // The status must be one of these four strings
        // Healthy, Quarantined, Covid-19 +, Recovered
        guard status == "Healthy" || status == "Quarantined" || status == "Covid-19 +" || status == "Recovered" else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.password = password
        self.status = status
    }
    
    //Failable initializer
    init? (name:String, email: String, password: String, status: String, age:Int, height:Int, weight:Int) {
        
        // The name must not be empty or less than 3 characters
        guard !name.isEmpty && name.count > 2 else {
            return nil
        }
        
        // The age must be between 18 - 100 yrs
        guard (age >= 18) && (age <= 100) else{
            return nil
        }
        
        
        // The height must be between 100 - 200 cm
        guard height >= 100 && height <= 200 else {
            return nil
        }
        
        // The weight must be between 30 - 200 kg
        guard weight >= 30 && weight <= 200 else {
            return nil
        }
        
        
        self.name = name
        self.email = email
        self.password = password
        self.status = status
        self.age = age
        self.height = height
        self.weight = weight
        //self.printPerson()
    }
    
    func setName (_ name: String) {
        self.name = name
    }
    
    func setHeight(_ height: Int) {
        guard let currentHeight = self.height else {
            if (height >= minHeight && height <= maxHeight) {
                self.height = height
            } else {
                print("Error setting height: Must be between 100 and 200")
            }
            return
        }
        if (height > currentHeight && height <= maxHeight) {
            self.height = height
        } else{
            print("Error setting height: Cannot reduce height or exceed max height i.e. 200cm")
        }
    }
    
    func setWeight(_ weight: Int) {
        if (weight >= minWeight && weight <= maxWeight) {
            self.weight = weight
        } else {
            print("Error setting weight: Must be between 30 - 200 kg")
        }
    }
    
    func setAge (_ age: Int) {
        guard let currentAge = self.age else {
            if (age >= minAge && age <= maxAge) {
                self.age = age
            } else {
                print ("Age must be between 18 - 100")
            }
            return
        }
        if (age > currentAge && age <= maxAge) {
            self.age = age
        } else {
            print("Error setting age: Cannot reduce age or exceed max age i.e. 100 yrs")
        }
    }
    
    func addProfession(_ profession: String) {
        if (professionSet.count < 5) {
        self.professionSet.insert(profession)
        } else {
            print("Error adding profession: profession list cannot contain more than five professions")
        }
    }
    
    func removeProfession(_ profession: String) {
        self.professionSet.remove(profession)
    }
    
    func printPerson () {
        print("New person instance created")
        print("Name: \(self.name)")
        if let age = self.age {
            print("Age: \(age)")
        }
        if let height = self.height {
            print("Height: \(height)")
        }
        if let weight = self.weight {
            print("Weight: \(weight)")
        }
        print("ProfessionList: \(self.professionSet)")
    }
}


//
//  User+CoreDataProperties.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 28.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var name: String?
    @NSManaged public var status: String?

}

//
//  User+CoreDataProperties.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 1.5.2020.
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
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var status: String?
    @NSManaged public var userHasSymptoms: NSSet?

}

// MARK: Generated accessors for userHasSymptoms
extension User {

    @objc(addUserHasSymptomsObject:)
    @NSManaged public func addToUserHasSymptoms(_ value: Symptom)

    @objc(removeUserHasSymptomsObject:)
    @NSManaged public func removeFromUserHasSymptoms(_ value: Symptom)

    @objc(addUserHasSymptoms:)
    @NSManaged public func addToUserHasSymptoms(_ values: NSSet)

    @objc(removeUserHasSymptoms:)
    @NSManaged public func removeFromUserHasSymptoms(_ values: NSSet)

}

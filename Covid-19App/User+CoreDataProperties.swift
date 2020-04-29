//
//  User+CoreDataProperties.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 29.4.2020.
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
    @NSManaged public var userHasSymptoms: NSOrderedSet?

}

// MARK: Generated accessors for userHasSymptoms
extension User {

    @objc(insertObject:inUserHasSymptomsAtIndex:)
    @NSManaged public func insertIntoUserHasSymptoms(_ value: Symptom, at idx: Int)

    @objc(removeObjectFromUserHasSymptomsAtIndex:)
    @NSManaged public func removeFromUserHasSymptoms(at idx: Int)

    @objc(insertUserHasSymptoms:atIndexes:)
    @NSManaged public func insertIntoUserHasSymptoms(_ values: [Symptom], at indexes: NSIndexSet)

    @objc(removeUserHasSymptomsAtIndexes:)
    @NSManaged public func removeFromUserHasSymptoms(at indexes: NSIndexSet)

    @objc(replaceObjectInUserHasSymptomsAtIndex:withObject:)
    @NSManaged public func replaceUserHasSymptoms(at idx: Int, with value: Symptom)

    @objc(replaceUserHasSymptomsAtIndexes:withUserHasSymptoms:)
    @NSManaged public func replaceUserHasSymptoms(at indexes: NSIndexSet, with values: [Symptom])

    @objc(addUserHasSymptomsObject:)
    @NSManaged public func addToUserHasSymptoms(_ value: Symptom)

    @objc(removeUserHasSymptomsObject:)
    @NSManaged public func removeFromUserHasSymptoms(_ value: Symptom)

    @objc(addUserHasSymptoms:)
    @NSManaged public func addToUserHasSymptoms(_ values: NSOrderedSet)

    @objc(removeUserHasSymptoms:)
    @NSManaged public func removeFromUserHasSymptoms(_ values: NSOrderedSet)

}

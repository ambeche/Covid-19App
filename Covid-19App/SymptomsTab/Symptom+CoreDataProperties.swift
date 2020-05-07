//
//  Symptom+CoreDataProperties.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 29.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//
//

import Foundation
import CoreData


extension Symptom {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Symptom> {
        return NSFetchRequest<Symptom>(entityName: "Symptom")
    }

    @NSManaged public var breathing: Bool
    @NSManaged public var chills: Bool
    @NSManaged public var cough: Bool
    @NSManaged public var date: Date?
    @NSManaged public var fever: Bool
    @NSManaged public var headache: Bool
    @NSManaged public var muscle: Bool
    @NSManaged public var taste: Bool
    @NSManaged public var throat: Bool
    @NSManaged public var time: String?
    @NSManaged public var symptomBelongToUser: User?

}

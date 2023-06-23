//
//  Semester+CoreDataProperties.swift
//  
//
//  Created by Mekhriddin Jumaev.
//
//

import Foundation
import CoreData


extension Semester {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Semester> {
        return NSFetchRequest<Semester>(entityName: "Semester")
    }

    @NSManaged public var key: Int16
    @NSManaged public var name: String?
    @NSManaged public var gpa: Double
    @NSManaged public var credits: Int16
    @NSManaged public var isMarked: Bool
    @NSManaged public var subjects: NSSet?

}

// MARK: Generated accessors for subjects
extension Semester {

    @objc(addSubjectsObject:)
    @NSManaged public func addToSubjects(_ value: Subject)

    @objc(removeSubjectsObject:)
    @NSManaged public func removeFromSubjects(_ value: Subject)

    @objc(addSubjects:)
    @NSManaged public func addToSubjects(_ values: NSSet)

    @objc(removeSubjects:)
    @NSManaged public func removeFromSubjects(_ values: NSSet)

}

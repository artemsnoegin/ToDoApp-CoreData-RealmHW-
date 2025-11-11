//
//  ToDoGroupEntity+CoreDataProperties.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 12.11.2025.
//
//

public import Foundation
public import CoreData


public typealias ToDoGroupEntityCoreDataPropertiesSet = NSSet

extension ToDoGroupEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoGroupEntity> {
        return NSFetchRequest<ToDoGroupEntity>(entityName: "ToDoGroupEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var dateAdded: Date
    @NSManaged public var items: NSSet

}

// MARK: Generated accessors for items
extension ToDoGroupEntity {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ToDoItemEntity)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ToDoItemEntity)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension ToDoGroupEntity : Identifiable {

}

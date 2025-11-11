//
//  ToDoItemEntity+CoreDataProperties.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 10.11.2025.
//
//

public import Foundation
public import CoreData


public typealias ToDoItemEntityCoreDataPropertiesSet = NSSet

extension ToDoItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItemEntity> {
        return NSFetchRequest<ToDoItemEntity>(entityName: "ToDoItemEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var isDone: Bool
    @NSManaged public var group: ToDoGroupEntity

}

extension ToDoItemEntity : Identifiable {

}

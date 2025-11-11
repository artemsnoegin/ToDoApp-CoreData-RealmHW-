//
//  ToDoItemEntity.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 11.11.2025.
//


import RealmSwift
import Foundation

class ToDoItemEntity: Object {
    
    @Persisted var id: UUID
    @Persisted var title: String
    @Persisted var dataAdded: Date
    @Persisted var isDone: Bool
    @Persisted(originProperty: "items") var group: LinkingObjects<ToDoGroupEntity>
    
    convenience init(id: UUID = UUID(), title: String, dateAdded: Date, isDone: Bool) {
        self.init()
        
        self.id = id
        self.title = title
        self.dataAdded = dateAdded
        self.isDone = isDone
    }
}

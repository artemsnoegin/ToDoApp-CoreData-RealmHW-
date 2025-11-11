//
//  ToDoGroupEntity.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 11.11.2025.
//

import RealmSwift
import Foundation

class ToDoGroupEntity: Object {
    
    @Persisted var id: UUID
    @Persisted var title: String
    @Persisted var dateAdded: Date
    @Persisted var items: List<ToDoItemEntity>
    
    convenience init(id: UUID = UUID(), title: String, dateAdded: Date, items: List<ToDoItemEntity> = List<ToDoItemEntity>()) {
        self.init()
        
        self.id = id
        self.title = title
        self.dateAdded = dateAdded
        self.items = items
    }
}

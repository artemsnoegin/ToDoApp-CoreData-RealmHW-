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
    @Persisted var items: List<ToDoItemEntity>
    
    convenience init(id: UUID = UUID(), title: String, items: List<ToDoItemEntity> = List<ToDoItemEntity>()) {
        self.init()
        
        self.id = id
        self.title = title
        self.items = items
    }
}

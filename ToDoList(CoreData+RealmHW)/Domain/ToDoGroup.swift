//
//  ToDoGroup.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 08.11.2025.
//

import Foundation

struct ToDoGroup: Identifiable, Equatable {
    
    let id: UUID
    var title: String
    var items: [ToDoItem]
    
    init(id: UUID = UUID(), title: String, items: [ToDoItem] = []) {
        
        self.id = id
        self.title = title
        self.items = items
    }
    
    static func ==(lhs: ToDoGroup, rhs: ToDoGroup) -> Bool {
        
        lhs.id == rhs.id
    }
}

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
    var dateAdded: Date
    var items: [ToDoItem]
    
    init(id: UUID = UUID(), title: String, dateAdded: Date = .now, items: [ToDoItem] = []) {
        
        self.id = id
        self.title = title
        self.dateAdded = dateAdded
        self.items = items
    }
    
    static func ==(lhs: ToDoGroup, rhs: ToDoGroup) -> Bool {
        
        lhs.id == rhs.id
    }
}

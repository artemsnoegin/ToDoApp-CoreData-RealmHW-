//
//  ToDoItem.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 08.11.2025.
//

import Foundation

struct ToDoItem: Identifiable, Equatable {
    
    let id: UUID
    var title: String
    var dateAdded: Date
    var isDone: Bool
    let groupId: UUID
    
    init(id: UUID = UUID(), title: String, dateAdded: Date = .now, isDone: Bool = false, groupId: UUID) {
        
        self.id = id
        self.title = title
        self.dateAdded = dateAdded
        self.isDone = isDone
        self.groupId = groupId
    }
    
    static func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        
        lhs.id == rhs.id
    }
}

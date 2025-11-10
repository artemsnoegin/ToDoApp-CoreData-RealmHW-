//
//  ToDoManager.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 08.11.2025.
//

import Foundation

class ToDoManager {
    
    var repository: ToDoRepository
    
    init(repository: ToDoRepository) {
        
        self.repository = repository
    }
    
    func createGroup(title: String) -> ToDoGroup {
        
        let group = ToDoGroup(title: title)
        repository.saveGroup(group)
        
        return group
    }
    
    func updateGroup(_ group: ToDoGroup) {
        
        repository.updateGroup(group)
    }
    
    func deleteGroup(_ group: ToDoGroup) {
        
        repository.deleteGroup(group)
    }
    
    func fetchGroups() -> [ToDoGroup] {
        
        repository.fetchGroups()
    }
    
    func createItem(title: String, group: ToDoGroup) -> ToDoItem {
        
        let item = ToDoItem(title: title, isDone: false, groupId: group.id)
        repository.saveItem(item)
        
        return item
    }
    
    func updateItem(_ item: ToDoItem) {
        
        repository.updateItem(item)
    }
    
    func deleteItem(_ item: ToDoItem) {
        
        repository.deleteItem(item)
    }
    
    func fetchItems(for group: ToDoGroup) -> [ToDoItem] {
        
        repository.fetchItems(for: group)
    }
}

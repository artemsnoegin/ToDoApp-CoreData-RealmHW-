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
    
    func fetchGroups() -> [ToDoGroup] {
        
        repository.fetchGroups()
    }
    
    func createGroup(title: String) -> ToDoGroup {
        
        let group = ToDoGroup(title: title)
        repository.saveGroup(group)
        
        return group
    }
    
    func renameGroup(_ group: ToDoGroup) {
        
        repository.renameGroup(group)
    }
    
    func deleteGroup(_ group: ToDoGroup) {
        
        repository.deleteGroup(group)
    }
    
    func createItem(title: String, group: ToDoGroup) -> ToDoItem {
        
        let item = ToDoItem(title: title, isDone: false, groupId: group.id)
        repository.saveItem(item)
        
        return item
    }
    
    func renameItem(_ item: ToDoItem) {
        
        repository.renameItem(item)
    }
    
    func markItem(_ item: ToDoItem) {
        
        repository.markItem(item)
    }
    
    func deleteItem(_ item: ToDoItem) {
        
        repository.deleteItem(item)
    }
}

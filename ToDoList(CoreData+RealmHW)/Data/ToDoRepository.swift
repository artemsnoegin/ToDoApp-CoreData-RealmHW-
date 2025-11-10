//
//  ToDoRepository.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 08.11.2025.
//

protocol ToDoRepository {
    
    func saveGroup(_ group: ToDoGroup)
    func updateGroup(_ group: ToDoGroup)
    func deleteGroup(_ group: ToDoGroup)
    
    func fetchGroups() -> [ToDoGroup]
    
    func saveItem(_ item: ToDoItem)
    func updateItem(_ item: ToDoItem)
    func deleteItem(_ item: ToDoItem)
    
    func fetchItems(for group: ToDoGroup) -> [ToDoItem]
}

//
//  ToDoRepository.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 08.11.2025.
//

protocol ToDoRepository {
    
    func fetchGroups() -> [ToDoGroup]
    
    func saveGroup(_ group: ToDoGroup)
    func renameGroup(_ group: ToDoGroup)
    func deleteGroup(_ group: ToDoGroup)
    
    func saveItem(_ item: ToDoItem)
    func renameItem(_ item: ToDoItem)
    func markItem(_ item: ToDoItem)
    func deleteItem(_ item: ToDoItem)
}

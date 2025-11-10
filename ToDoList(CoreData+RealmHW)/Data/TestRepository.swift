//
//  TestRepository.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 08.11.2025.
//

class TestRepository: ToDoRepository {

    private var storage = [ToDoGroup]()
    
    init() {
        
        createMockData()
    }
    
    func saveGroup(_ group: ToDoGroup) {
        
        storage.append(group)
    }
    
    func updateGroup(_ group: ToDoGroup) {
        
        guard let groupId = storage.firstIndex(of: group) else { return }
        
        storage[groupId] = group
    }
    
    func deleteGroup(_ group: ToDoGroup) {
        
        guard let groupId = storage.firstIndex(of: group) else { return }
        
        storage.remove(at: groupId)
    }
    
    func fetchGroups() -> [ToDoGroup] {
        
        return storage
    }
    
    func saveItem(_ item: ToDoItem) {
        
        guard let groupId = storage.firstIndex(where: { $0.id == item.groupId }) else { return }
        
        storage[groupId].items.append(item)
    }
    
    func updateItem(_ item: ToDoItem) {
        
        guard let groupId = storage.firstIndex(where: { $0.id == item.groupId }),
              let itemId = storage[groupId].items.firstIndex(of: item)
        else { return }
        
        storage[groupId].items[itemId] = item
    }
    
    func deleteItem(_ item: ToDoItem) {
        
        guard let groupId = storage.firstIndex(where: { $0.id == item.groupId }),
              let itemId = storage[groupId].items.firstIndex(of: item )
        else { return }
        
        storage[groupId].items.remove(at: itemId)
    }
    
    func fetchItems(for group: ToDoGroup) -> [ToDoItem] {
        
        guard let groupId = storage.firstIndex(where: { $0.id == group.id })
        else { return [] }
        
        return storage[groupId].items
    }
}

extension TestRepository {
    
    func createMockData() {
        
        for g in 1...5 {
            
            let group = ToDoGroup(title: "Group \(g)")
            saveGroup(group)
            
            for i in 1...5 {
                
                let item = ToDoItem(title: "Item \(i)", groupId: group.id)
                saveItem(item)
            }
        }
    }
}

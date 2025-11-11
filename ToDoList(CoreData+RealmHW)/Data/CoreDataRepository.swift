//
//  CoreDataRepository.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 10.11.2025.
//

import CoreData

class CoreDataRepository: ToDoRepository {
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ToDoModel")
        
        container.loadPersistentStores { _, error in
            
            if let error = error {
                
                fatalError("Error loading Core Data: \(error)")
            }
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            
            do {
                try context.save()
            } catch {
                fatalError("Error saving: \(error)")
            }
        }
    }
    
    func fetchGroups() -> [ToDoGroup] {
        
        let request: NSFetchRequest<ToDoGroupEntity> = ToDoGroupEntity.fetchRequest()
        
        do {
            let entities = try context.fetch(request)
            print(entities)
            
            return mapGroups(entities: entities)
        }
        catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveGroup(_ group: ToDoGroup) {
        
        let groupEntity = ToDoGroupEntity(context: context)
        
        groupEntity.id = group.id
        groupEntity.title = group.title
        groupEntity.dateAdded = group.dateAdded
        groupEntity.items = []
        
        saveContext()
    }
    
    func renameGroup(_ group: ToDoGroup) {
        
        if let entity = fetchGroup(id: group.id) {
            
            entity.title = group.title
            saveContext()
        }
    }
    
    func deleteGroup(_ group: ToDoGroup) {
        
        if let entity = fetchGroup(id: group.id) {
            
            context.delete(entity)
            saveContext()
        }
    }
    
    func saveItem(_ item: ToDoItem) {
        
        let itemEntity = ToDoItemEntity(context: context)
        
        itemEntity.id = item.id
        itemEntity.title = item.title
        itemEntity.dateAdded = item.dateAdded
        itemEntity.isDone = item.isDone
        
        if let groupEntity = fetchGroup(id: item.groupId) {
            
            itemEntity.group = groupEntity
            saveContext()
        }
    }
    
    func renameItem(_ item: ToDoItem) {
        
        if let entity = fetchItem(id: item.id) {
            
            entity.title = item.title
            saveContext()
        }
    }
    
    func markItem(_ item: ToDoItem) {
        
        if let entity = fetchItem(id: item.id) {
            
            entity.isDone = item.isDone
            saveContext()
        }
    }
    
    func deleteItem(_ item: ToDoItem) {
        
        if let entity = fetchItem(id: item.id) {
            
            context.delete(entity)
            saveContext()
        }
    }
}

extension CoreDataRepository {
    
    private func fetchGroup(id: UUID) -> ToDoGroupEntity? {
        
        let request = ToDoGroupEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            return try context.fetch(request).first
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func fetchItem(id: UUID) -> ToDoItemEntity? {
        
        let request = ToDoItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            return try context.fetch(request).first
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func mapGroups(entities: [ToDoGroupEntity]) -> [ToDoGroup] {
        
        return entities.map { entityGroup in
            ToDoGroup(id: entityGroup.id, title: entityGroup.title,
                      dateAdded: entityGroup.dateAdded,
                      items: mapItems(entities: entityGroup.items))
        }
    }
    
    private func mapItems(entities: NSSet) -> [ToDoItem] {
        
        return (entities as! Set<ToDoItemEntity>).map { itemEntity in
            
            ToDoItem(id: itemEntity.id, title: itemEntity.title,
                     dateAdded: itemEntity.dateAdded,
                     isDone: itemEntity.isDone, groupId: itemEntity.group.id)
        }
    }
}

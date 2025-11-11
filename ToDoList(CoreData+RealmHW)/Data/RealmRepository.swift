//
//  RealmRepository.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 11.11.2025.
//

import RealmSwift
import Foundation

class RealmRepository: ToDoRepository {
    
    private var realm: Realm {
        
        do {
            return try Realm()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchGroups() -> [ToDoGroup] {
        
        let entities = realm.objects(ToDoGroupEntity.self)
        
        return mapGroups(entities: entities)
    }
    
    func saveGroup(_ group: ToDoGroup) {
        
        let entity = ToDoGroupEntity(id: group.id, title: group.title)
        
        do {
            try realm.write {
                realm.add(entity)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func renameGroup(_ group: ToDoGroup) {
        
        if let entity = realm.objects(ToDoGroupEntity.self).filter("id == %@", group.id).first {
            
            do {
                try realm.write {
                    entity.title = group.title
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteGroup(_ group: ToDoGroup) {
        
        if let entity = realm.objects(ToDoGroupEntity.self).filter("id == %@", group.id).first {
            
            do {
                try realm.write {
                    realm.delete(entity)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func saveItem(_ item: ToDoItem) {
        
        if let groupEntity = realm.objects(ToDoGroupEntity.self).filter("id == %@", item.groupId).first {
            
            let itemEntity = ToDoItemEntity(id: item.id, title: item.title, isDone: item.isDone)
            
            do {
                try realm.write {
                    groupEntity.items.append(itemEntity)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func renameItem(_ item: ToDoItem) {
        
        if let entity = realm.objects(ToDoItemEntity.self).filter("id == %@", item.id).first {
            
            do {
                try realm.write {
                    entity.title = item.title
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func markItem(_ item: ToDoItem) {
        
        if let entity = realm.objects(ToDoItemEntity.self).filter("id == %@", item.id).first {
            
            do {
                try realm.write {
                    entity.isDone = item.isDone
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteItem(_ item: ToDoItem) {
        
        if let entity = realm.objects(ToDoItemEntity.self).filter("id == %@", item.id).first {
            
            do {
                try realm.write {
                    realm.delete(entity)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension RealmRepository {
    
    private func mapGroups(entities: Results<ToDoGroupEntity>) -> [ToDoGroup] {
        
        entities.map { entity in
            
            ToDoGroup(id: entity.id, title: entity.title, items: mapItems(entities: entity.items, groupId: entity.id))
        }
    }
    
    private func mapItems(entities: List<ToDoItemEntity>, groupId: UUID) -> [ToDoItem] {
        
        entities.map { entity in
            
            ToDoItem(id: entity.id , title: entity.title, isDone: entity.isDone, groupId: groupId)
        }
    }
}

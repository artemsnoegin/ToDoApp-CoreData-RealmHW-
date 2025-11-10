//
//  AppContainer.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 08.11.2025.
//

class AppContainer {
    static let shared = AppContainer()
    
    let manager: ToDoManager
    
    private init() {
        
        let repository = TestRepository()
        manager = ToDoManager(repository: repository)
    }
}

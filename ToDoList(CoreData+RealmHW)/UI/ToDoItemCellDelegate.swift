//
//  ToDoItemCellDelegate.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 10.11.2025.
//

protocol ToDoItemCellDelegate: AnyObject {
    
    func didPressReturn(in cell: ToDoItemCell)
    func didEndEditing(text: String, in cell: ToDoItemCell)
    func didToggleCheckmark(state: Bool, in cell: ToDoItemCell)
}

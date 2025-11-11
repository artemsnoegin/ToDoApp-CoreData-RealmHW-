//
//  ToDoViewController.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 08.11.2025.
//

import UIKit

class ToDoViewController: UIViewController {
    
    private let manager: ToDoManager
    private var groups = [ToDoGroup]()
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    init(manager: ToDoManager) {
        
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "To Do"
        view.backgroundColor = .systemBackground
        
        loadGroups()
        setupTableView()
        setupNavigationBar()
        subscribeNotification()
    }
    
    private func loadGroups() {
        
        //TODO: fix order of todos
        groups = manager.fetchGroups()
    }
    
    private func setupNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        
        tableView.endEditing(true)
        
        // TODO: Add empty group to table and change its title from there
        
        let alert = UIAlertController(title: "Group", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            
            textField.placeholder = "Tile"
        }
        
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            
            if let text = alert.textFields?.first?.text {
                
                var newGroup = self.manager.createGroup(title: text)
                let newItem = self.manager.createItem(title: "", group: newGroup)
                newGroup.items.append(newItem)
                
                self.groups.insert(newGroup, at: 0)
                self.tableView.performBatchUpdates({
                    
                    self.tableView.insertSections(IndexSet(integer: 0), with: .automatic)
                    
                }) { _ in
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                                    
                    if let cell = self.tableView.cellForRow(
                        at: IndexPath(row: 0, section: 0)) as? ToDoItemCell {
                        
                        cell.textFieldBecomeFirstResponder()
                    }
                }
            }
        }
        alert.addAction(add)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    private func setupTableView() {
        
        tableView.keyboardDismissMode = .interactive
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoItemCell.self, forCellReuseIdentifier: ToDoItemCell.reuseId)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func subscribeNotification() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        
        tableView.contentInset.bottom = keyboardFrame.height - view.safeAreaInsets.bottom
        tableView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height - view.safeAreaInsets.bottom

        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseIn]) {
            
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        tableView.contentInset.bottom = 0
        tableView.verticalScrollIndicatorInsets.bottom = 0

        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseIn]) {
            
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITableViewDelegate
extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? ToDoItemCell
        cell?.textFieldBecomeFirstResponder()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ToDoViewController: UITableViewDataSource {
    
    // TODO: Custom textfield view for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let group = groups[section]
        return "\(group.title)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        groups[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoItemCell.reuseId, for: indexPath) as? ToDoItemCell else { return UITableViewCell()}
        
        let item = groups[indexPath.section].items[indexPath.row]
        
        cell.configure(text: item.title, checkmarkState: item.isDone)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let group = groups[indexPath.section]
            let item = groups[indexPath.section].items[indexPath.row]
            
            groups[indexPath.section].items.remove(at: indexPath.row)
            
            if groups[indexPath.section].items.isEmpty {
                
                manager.deleteGroup(group)
                groups.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            }
            else {
                
                manager.deleteItem(item)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

//MARK: - ToDoItemCellDelegate
extension ToDoViewController: ToDoItemCellDelegate {
    
    func didPressReturn(in cell: ToDoItemCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let item = groups[indexPath.section].items[indexPath.row]
        
        if item == groups[indexPath.section].items.last {
            
            let newItem = manager.createItem(title: "", group: groups[indexPath.section])
            groups[indexPath.section].items.append(newItem)
            
            let newIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            
            tableView.performBatchUpdates {
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            
            let cell = tableView.cellForRow(at: newIndexPath) as! ToDoItemCell
            cell.textFieldBecomeFirstResponder()
            
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
    
    func didEndEditing(text: String, in cell: ToDoItemCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        // TODO: Fix index out of range when creating new group during renaming last item
        var item = groups[indexPath.section].items[indexPath.row]
        groups[indexPath.section].items[indexPath.row].title = text
        
        item.title = text
        manager.renameItem(item)
    }
    
    func didToggleCheckmark(state: Bool, in cell: ToDoItemCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        var item = groups[indexPath.section].items[indexPath.row]
        groups[indexPath.section].items[indexPath.row].isDone = state
        
        item.isDone = state
        manager.markItem(item)
    }
}

// MARK: - Preview
#Preview("Preview") {
    let present = UINavigationController(rootViewController: ToDoViewController(manager: AppContainer.shared.manager))
    return present
}

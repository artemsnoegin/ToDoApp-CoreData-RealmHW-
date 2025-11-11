//
//  ToDoItemCell.swift
//  ToDoList(CoreData+RealmHW)
//
//  Created by Артём Сноегин on 10.11.2025.
//

import UIKit

class ToDoItemCell: UITableViewCell {
    
    weak var delegate: ToDoItemCellDelegate?
    
    static let reuseId = "ToDoItemCellView"
    
    private let checkMarkButton = UIButton()
    private let textField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, checkmarkState: Bool) {
        
        textField.text = text
        checkMarkButton.isSelected = checkmarkState
    }
    
    func textFieldBecomeFirstResponder() {
        
        textField.becomeFirstResponder()
    }
    
    func textFieldResignFirstResponder() {
        
        textField.resignFirstResponder()
    }
    
    private func setupUI() {
        
        // TODO: Increase button image size
        checkMarkButton.setImage(UIImage(systemName: "square"), for: .normal)
        checkMarkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkMarkButton.addTarget(self, action: #selector(markAsDone), for: .touchUpInside)
        
        textField.placeholder = "To do..."
        textField.font = .preferredFont(forTextStyle: .headline)
        textField.delegate = self
        
        // TODO: Add drag indicator
        
        let spacer = UIView()
        
        let stackView = UIStackView(arrangedSubviews: [checkMarkButton, textField, spacer])
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            checkMarkButton.widthAnchor.constraint(equalToConstant: 30),
//            checkMarkButton.heightAnchor.constraint(equalToConstant: 30),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
    @objc private func markAsDone() {
        
        checkMarkButton.isSelected.toggle()
        
        textField.textColor = checkMarkButton.isSelected ? .secondaryLabel : .label
        
        delegate?.didToggleCheckmark(state:  checkMarkButton.isSelected, in: self)
    }
}

extension ToDoItemCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        delegate?.didPressReturn(in: self)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        delegate?.didEndEditing(text: text, in: self)
    }
}

// MARK: - Preview
#Preview("Preview") {
    
    let present = ToDoItemCell()
    return present
}

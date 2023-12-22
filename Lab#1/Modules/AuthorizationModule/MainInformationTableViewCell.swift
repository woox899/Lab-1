//
//  MainInformationTableViewCell.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 24.10.2023.
//

import UIKit

protocol MainInformationTableViewCellDelegate: AnyObject {
    func updateText(type: CellType, text: String?)
}

final class MainInformationTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    weak var delegate: MainInformationTableViewCellDelegate?
    
    static let reuseID = "MainInformationTableViewCell"
    
    private var type: CellType?
    
    private lazy var textfield: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 20, y: 15, width: UIScreen.main.bounds.width - 40, height: 30))
        textfield.borderStyle = .roundedRect
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        return textfield
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(type: CellType, filledText: String?) {
        textfield.placeholder = type.rawValue
        textfield.text = filledText
        self.type = type
    }
    
    private func setupUI() {
        contentView.addSubview(textfield)
    }
    
    @objc private func textChanged() {
        guard let type else {
            return
        }
        delegate?.updateText(type: type, text: textfield.text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

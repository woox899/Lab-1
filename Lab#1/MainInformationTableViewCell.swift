//
//  MainInformationTableViewCell.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 24.10.2023.
//

import UIKit

final class MainInformationTableViewCell: UITableViewCell {
    
    static let reuseID = "MainInformationTableViewCell"
    
    private var model: AuthorizationOptions?
   
    private let texfield: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 20, y: 5, width: UIScreen.main.bounds.width - 40, height: 30))
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: MainInformationTableViewCell.reuseID)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: AuthorizationOptions) {
        texfield.placeholder = model.typeOfRegistration.text
    }
    
    func setupUI() {
        contentView.addSubview(texfield)
    }
}

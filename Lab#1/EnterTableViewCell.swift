//
//  EnterTableViewCell.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 13.11.2023.
//

import UIKit

protocol EnterTableViewCellDelegate: AnyObject {
    func loginButtonTapped()
}

final class EnterTableViewCell: UITableViewCell {
    
    static let reuseID = "EnterTableViewCell"

    weak var delegate: EnterTableViewCellDelegate?

    private lazy var enterButton: UIButton = {
        let enterButton = UIButton(frame: CGRect(x: 100, y: 15, width: UIScreen.main.bounds.width - 200, height: 30))
        enterButton.setTitle("Войти", for: .normal)
        enterButton.setTitleColor(.blue, for: .normal)
        enterButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return enterButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(enterButton)
    }

    @objc private func buttonTapped() {
        delegate?.loginButtonTapped()
    }
}

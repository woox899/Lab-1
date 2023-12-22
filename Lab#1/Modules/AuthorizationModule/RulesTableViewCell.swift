//
//  RulesTableViewCell.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 24.10.2023.
//

import UIKit

protocol RulesTableViewCellDelegate: AnyObject {
    func registerButtonTapped()
}

final class RulesTableViewCell: UITableViewCell {
    
    static let reuseID = "RulesTableViewCell"

    weak var delegate: RulesTableViewCellDelegate?
    
    private let agreeWithTheRulesLabel: UILabel = {
        let agreeWithTheRulesLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 30))
        agreeWithTheRulesLabel.text = "Согласен с правилами"
        return agreeWithTheRulesLabel
    }()
    
    private let agreeWithTheRulesLabelSwitch: UISwitch = {
        let agreeWithTheRulesLabelSwitch = UISwitch(frame: CGRect(x: UIScreen.main.bounds.width - 70, y: 0, width: 0, height: 0))
        return agreeWithTheRulesLabelSwitch
    }()
    
    private lazy var registrationButton: UIButton = {
        let registrationButton = UIButton(frame: CGRect(x: 100, y: 30, width: UIScreen.main.bounds.width - 200, height: 30))
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.setTitleColor(UIColor.blue, for: .normal)
        registrationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return registrationButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(agreeWithTheRulesLabel)
        contentView.addSubview(agreeWithTheRulesLabelSwitch)
        contentView.addSubview(registrationButton)
    }

    @objc private func buttonTapped() {
        delegate?.registerButtonTapped()
    }
}

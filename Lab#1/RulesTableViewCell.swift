//
//  RulesTableViewCell.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 24.10.2023.
//

import UIKit

final class RulesTableViewCell: UITableViewCell {
    
    static let reuseID = "RulesTableViewCell"
    
    private let agreeWithTheRulesLabel: UILabel = {
        let agreeWithTheRulesLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 30))
        agreeWithTheRulesLabel.text = "Согласен с правилами"
        return agreeWithTheRulesLabel
    }()
    
    private let agreeWithTheRulesLabelSwitch: UISwitch = {
        let agreeWithTheRulesLabelSwitch = UISwitch(frame: CGRect(x: 305, y: 0, width: 50, height: 30))
        return agreeWithTheRulesLabelSwitch
    }()
    
    private let registrationButton: UIButton = {
        let registrationButton = UIButton(frame: CGRect(x: 100, y: 30, width: UIScreen.main.bounds.width - 200, height: 30))
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.setTitleColor(UIColor.blue, for: .normal)
        return registrationButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "")
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
}

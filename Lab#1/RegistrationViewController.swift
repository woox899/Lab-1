//
//  RegistrationViewController.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 23.10.2023.
//

import UIKit

final class RegistrationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let authorizationOptionsLoginArray: [CellType] = [.login, .password]
    
    private let authorizationOptionsRegistrationArray: [CellType] = [.login, .email, .password, .repeatPassword]
    
    private var dataSourse: [CellType] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(RulesTableViewCell.self, forCellReuseIdentifier: RulesTableViewCell.reuseID)
        tableView.register(MainInformationTableViewCell.self, forCellReuseIdentifier: MainInformationTableViewCell.reuseID)
        return tableView
    }()
    
    private let headerView: UIView = {
        let headerView = UIView()
        return headerView
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let itemsArraySegmentControl = ["Вход", "Регистрация"]
        let segmentControl = UISegmentedControl(items: itemsArraySegmentControl)
        segmentControl.frame = CGRect(x: 50, y: 0, width: 275, height: 50)
        segmentControl.addTarget(self, action: #selector(changeDataSourse), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        changeDataSourse()
    }
    
    @objc func changeDataSourse() {
        if segmentControl.selectedSegmentIndex == 0 {
            dataSourse = authorizationOptionsLoginArray
        }
        if segmentControl.selectedSegmentIndex == 1 {
            dataSourse = authorizationOptionsRegistrationArray
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 1 {
            dataSourse.count + 1
        } else {
            dataSourse.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == dataSourse.count {
            guard let rulesTableViewCell = tableView.dequeueReusableCell(withIdentifier: RulesTableViewCell.reuseID, for: indexPath) as? RulesTableViewCell else {
                return UITableViewCell()
            }
            rulesTableViewCell.selectionStyle = .none
            return rulesTableViewCell
        } else {
            guard let mainInformationTableViewCell = tableView.dequeueReusableCell(withIdentifier: MainInformationTableViewCell.reuseID, for: indexPath) as? MainInformationTableViewCell else {
                return UITableViewCell()
            }
            mainInformationTableViewCell.selectionStyle = .none
            mainInformationTableViewCell.configure(model: dataSourse[indexPath.row])
            return mainInformationTableViewCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        80
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        headerView.addSubview(segmentControl)
    }
}


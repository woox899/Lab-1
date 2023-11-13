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
    
    private var loginText: String?
    private var emailText: String?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(RulesTableViewCell.self, forCellReuseIdentifier: RulesTableViewCell.reuseID)
        tableView.register(MainInformationTableViewCell.self, forCellReuseIdentifier: MainInformationTableViewCell.reuseID)
        tableView.register(EnterTableViewCell.self, forCellReuseIdentifier: EnterTableViewCell.reuseID)
        return tableView
    }()
    
    private let headerView: UIView = {
        let headerView = UIView()
        return headerView
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let itemsArraySegmentControl = ["Вход", "Регистрация"]
        var segmentControl = UISegmentedControl(items: itemsArraySegmentControl)
        segmentControl.frame = CGRect(x: 50, y: 0, width: UIScreen.main.bounds.width - 100 , height: 50)
        segmentControl.addTarget(self, action: #selector(changeDataSourse), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 1
        return segmentControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: UserDefaultsKyes.isRegistered) == true {
            segmentControl.selectedSegmentIndex = 0
        }
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
        dataSourse.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == dataSourse.count {
            
            if segmentControl.selectedSegmentIndex == 0 {
                guard let enterTableViewCell = tableView.dequeueReusableCell(withIdentifier: EnterTableViewCell.reuseID, for: indexPath) as? EnterTableViewCell else {
                    return UITableViewCell()
                }
                enterTableViewCell.delegate = self
                return enterTableViewCell
            } else if segmentControl.selectedSegmentIndex == 1 {
                guard let rulesTableViewCell = tableView.dequeueReusableCell(withIdentifier: RulesTableViewCell.reuseID, for: indexPath) as? RulesTableViewCell else {
                    return UITableViewCell()
                }
                rulesTableViewCell.delegate = self
                rulesTableViewCell.selectionStyle = .none
                return rulesTableViewCell
            } else {
                return UITableViewCell()
            }
        } else {
            guard let mainInformationTableViewCell = tableView.dequeueReusableCell(withIdentifier: MainInformationTableViewCell.reuseID, for: indexPath) as? MainInformationTableViewCell else {
                return UITableViewCell()
            }
            mainInformationTableViewCell.selectionStyle = .none
            mainInformationTableViewCell.configure(type: dataSourse[indexPath.row])
            mainInformationTableViewCell.delegate = self
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

    private func login() {
        UserDefaults.standard.setValue(true, forKey: UserDefaultsKyes.isActiveSession)
        navigationController?.viewControllers = [MainViewController()]
    }
    
    private func registerUser() {
        guard let emailText, let loginText else {
            return
        }
        UserDefaults.standard.setValue(loginText, forKey: UserDefaultsKyes.login)
        UserDefaults.standard.setValue(emailText, forKey: UserDefaultsKyes.email)
        UserDefaults.standard.setValue(true, forKey: UserDefaultsKyes.isRegistered)
        UserDefaults.standard.setValue(true, forKey: UserDefaultsKyes.isActiveSession)
        navigationController?.viewControllers = [MainViewController()]
    }
}

extension RegistrationViewController: MainInformationTableViewCellDelegate {
    func updateText(type: CellType, text: String?) {
        switch type {
        case .login:
            loginText = text
        case .email:
            emailText = text
        case .password:
            break
        case .repeatPassword:
            break
        }
    }
}

extension RegistrationViewController: RulesTableViewCellDelegate {
    func registerButtonTapped() {
        registerUser()
    }
}

extension RegistrationViewController: EnterTableViewCellDelegate {
    func loginButtonTapped() {
        login()
    }
}


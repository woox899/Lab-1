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
    private var passwordText: String?
    private var repeatPasswordText: String?
    
    let viewModel: TrackListViewModelProtocol = TrackListViewModel()
    
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
    
    @objc private func changeDataSourse() {
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
                enterTableViewCell.selectionStyle = .none
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
            mainInformationTableViewCell.configure(type: dataSourse[indexPath.row], filledText: nil)
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
        guard enteredLoginAndPasswordValid() else { return }
        UserDefaults.standard.setValue(true, forKey: UserDefaultsKyes.isActiveSession)
        navigationController?.viewControllers = [TrackListViewController(viewModel: viewModel)]
    }
    
    private func registerUser() {
        guard allTextfieldsIsValid() else { return }
        UserDefaults.standard.setValue(loginText, forKey: UserDefaultsKyes.login)
        UserDefaults.standard.setValue(emailText, forKey: UserDefaultsKyes.email)
        UserDefaults.standard.setValue(passwordText, forKey: UserDefaultsKyes.password)
        UserDefaults.standard.setValue(repeatPasswordText, forKey: UserDefaultsKyes.repeatPassword)
        UserDefaults.standard.setValue(true, forKey: UserDefaultsKyes.isRegistered)
        UserDefaults.standard.setValue(true, forKey: UserDefaultsKyes.isActiveSession)
        navigationController?.viewControllers = [TrackListViewController(viewModel: viewModel)]
    }
    
    private func showAlertMassage(_ alertMassage: String) {
        let alertController = UIAlertController(title: "Ошибка", message: alertMassage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: .default))
        self.present(alertController, animated: true)
    }
    
    private func emailValidation(_ email: String) -> Bool {
        let emailRegExp: String = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
        return emailTest.evaluate(with: email)
    }
    
    private func passwordValidation(_ password: String) -> Bool {
        let passwordRegExp: String = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegExp)
        return passwordTest.evaluate(with: password)
    }
    
    private func allTextfieldsIsValid() -> Bool {
        guard let emailText, let loginText, let passwordText, let repeatPasswordText else {
            showAlertMassage("Поля не заполнены!")
            return false
        }
        guard !emailText.isEmpty, !loginText.isEmpty, !passwordText.isEmpty, !repeatPasswordText.isEmpty else {
            showAlertMassage("Поля не заполнены!")
            return false
        }
        guard emailValidation(emailText) else {
            showAlertMassage("Некорректный Email!")
            return false
        }
        guard passwordValidation(passwordText) else {
            showAlertMassage("Некорректный пароль! Пароль должен состоять не менее чем из 8 символов, содержать хотя бы одну заглавную букву, одну строчную букву и одну цифру.")
            return false
        }
        guard passwordText == repeatPasswordText else {
            showAlertMassage("Пароли не совпадают!")
            return false
        }
        return true
    }
    
    private func enteredLoginAndPasswordValid() -> Bool {
        guard let loginToBeEntered = UserDefaults.standard.string(forKey: UserDefaultsKyes.login),
              !loginToBeEntered.isEmpty,
              loginToBeEntered == loginText else {
            showAlertMassage("Неверный логин")
            return false
        }
        guard let enteredPassword = UserDefaults.standard.string(forKey: UserDefaultsKyes.password),
              !enteredPassword.isEmpty,
              enteredPassword == passwordText else {
            showAlertMassage("Неверный пароль")
            return false
        }
        return true
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
            passwordText = text
        case .repeatPassword:
            repeatPasswordText = text
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


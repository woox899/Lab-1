//
//  MainViewController.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 13.11.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 40, y: UIScreen.main.bounds.height / 2, width: 80, height: 40))
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonLogout), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        
        view.backgroundColor = .systemRed
    }
    
    @objc func buttonLogout() {
        UserDefaults.standard.setValue(false, forKey: UserDefaultsKyes.isActiveSession)
        navigationController?.viewControllers = [RegistrationViewController()]
    }
}

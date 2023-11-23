//
//  TrackListViewController.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 13.11.2023.
//

import UIKit

final class TrackListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    private lazy var trackListTableView: UITableView = {
        let view = UITableView(frame: view.bounds, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.register(TrackListTableViewCell.self, forCellReuseIdentifier: TrackListTableViewCell.reuseID)
        return view
    }()
    
    //MARK: - куда-то деть кнопку выхода из приложения
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 40, y: UIScreen.main.bounds.height / 2, width: 80, height: 40))
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonLogout), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .systemRed
    }
    
    func setupUI() {
        view.addSubview(button)
        view.addSubview(trackListTableView)
    }
    
    @objc func buttonLogout() {
        UserDefaults.standard.setValue(false, forKey: UserDefaultsKyes.isActiveSession)
        navigationController?.viewControllers = [RegistrationViewController()]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trackListTableViewCell = trackListTableView.dequeueReusableCell(withIdentifier: TrackListTableViewCell.reuseID, for: indexPath) as? TrackListTableViewCell else {
            return UITableViewCell()
        }
        return trackListTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func goToRecordPlayerViewController() {
        let recordPlayerViewController = RecordPlayerViewController()
        present(recordPlayerViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToRecordPlayerViewController()
    }
}

//
//  TrackListViewController.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 13.11.2023.
//

import UIKit
import SnapKit
import Moya

final class TrackListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let servive = APIService()
    private var tracks = [TracksModel]()
    
    private lazy var trackListTableView: UITableView = {
        let view = UITableView(frame: view.bounds, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(TrackListTableViewCell.self, forCellReuseIdentifier: TrackListTableViewCell.reuseID)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
        getTracks()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor(red: 222/255, green: 3/255, blue: 64/255, alpha: 1)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: nil, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "icloud.and.arrow.down"), style: .plain, target: nil, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.left.circle.fill"), style: .plain, target: self, action: #selector(buttonLogout))
        ]
    }
    
    func setupUI() {
        view.addSubview(trackListTableView)
    }
    
    @objc func buttonLogout() {
        UserDefaults.standard.setValue(false, forKey: UserDefaultsKyes.isActiveSession)
        navigationController?.viewControllers = [RegistrationViewController()]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trackListTableViewCell = trackListTableView.dequeueReusableCell(withIdentifier: TrackListTableViewCell.reuseID, for: indexPath) as? TrackListTableViewCell else {
            return UITableViewCell()
        }
        trackListTableViewCell.selectionStyle = .none
        trackListTableViewCell.configure(track: tracks[indexPath.row])
        return trackListTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recordPlayerViewController = RecordPlayerViewController(tracks: tracks, currentIndex: indexPath.row)
        present(recordPlayerViewController, animated: true)
    }
    
    func getTracks() {
        servive.getTracks() { [weak self] result in
            switch result {
            case .success(let tracks):
                self?.tracks = tracks
                self?.trackListTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

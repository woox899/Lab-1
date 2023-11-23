//
//  TrackListTableViewCell.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 23.11.2023.
//

import UIKit
import SnapKit

final class TrackListTableViewCell: UITableViewCell {
    
    static let reuseID = "TrackListTableViewCell"
    
    private let trackSmallImageView: UIImageView = {
        let trackImageView = UIImageView()
        trackImageView.translatesAutoresizingMaskIntoConstraints = false
        trackImageView.layer.cornerRadius = 8
        trackImageView.clipsToBounds = true
        trackImageView.backgroundColor = .systemBlue
        return trackImageView
    }()
    
    private let trackNameLabel: UILabel = {
        let trackNameLabel = UILabel()
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        trackNameLabel.text = "Numb"
        return trackNameLabel
    }()
    
    private let performerNameLabel: UILabel = {
        let performerNameLabel = UILabel()
        performerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        performerNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        performerNameLabel.text = "Linkin Park"
        return performerNameLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(trackSmallImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(performerNameLabel)
        
        trackSmallImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(trackSmallImageView.snp.trailing).offset(20)
            make.top.equalTo(contentView.snp.top).offset(15)
        }
        
        performerNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(trackSmallImageView.snp.trailing).offset(20)
            make.top.equalTo(trackNameLabel.snp.bottom).offset(5)
        }
    }
}

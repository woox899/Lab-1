//
//  RecordPlayerViewController.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 23.11.2023.
//

import UIKit
import SnapKit

final class RecordPlayerViewController: UIViewController {
    
    private let recordPlayerTrackImageView: UIImageView = {
        let recordPlayerTrackImageView = UIImageView()
        recordPlayerTrackImageView.backgroundColor = .white
        recordPlayerTrackImageView.translatesAutoresizingMaskIntoConstraints = false
        recordPlayerTrackImageView.layer.cornerRadius = 10
        return recordPlayerTrackImageView
    }()
    
    private let recordPlayerTrackNameLabel: UILabel = {
        let recordPlayerTrackNameLabel = UILabel()
        recordPlayerTrackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recordPlayerTrackNameLabel.text = "Numb"
        recordPlayerTrackNameLabel.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        recordPlayerTrackNameLabel.textColor = .white
        return recordPlayerTrackNameLabel
    }()
    
    private let recordPlayerPerformerNameLabel: UILabel = {
        let recordPlayerPerformerNameLabel = UILabel()
        recordPlayerPerformerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recordPlayerPerformerNameLabel.text = "Linkin Park"
        recordPlayerPerformerNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        recordPlayerPerformerNameLabel.textColor = .white
        return recordPlayerPerformerNameLabel
    }()
    
    private let trackSlider: UISlider = {
        let trackSlider = UISlider()
        trackSlider.translatesAutoresizingMaskIntoConstraints = false
        return trackSlider
    }()
    
    private let playPauseButton: UIButton = {
        let playPauseButton = UIButton()
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        playPauseButton.imageView?.contentMode = .scaleAspectFit
        return playPauseButton
    }()
    
    private let backwardButton: UIButton = {
        let backwardButton = UIButton()
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.setImage(UIImage(named: "backward"), for: .normal)
        backwardButton.imageView?.contentMode = .scaleAspectFit
        return backwardButton
    }()
    
    private let forwardButton: UIButton = {
        let forwardButton = UIButton()
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.setImage(UIImage(named: "forward"), for: .normal)
        forwardButton.imageView?.contentMode = .scaleAspectFit
        return forwardButton
    }()
    
    private let additionalFeaturesButton: UIButton = {
        let additionalFeaturesButton = UIButton()
        additionalFeaturesButton.translatesAutoresizingMaskIntoConstraints = false
        additionalFeaturesButton.setImage(UIImage(named: "ellipsiswhite"), for: .normal)
        additionalFeaturesButton.imageView?.contentMode = .scaleAspectFit
        additionalFeaturesButton.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 70/255, alpha: 1)
        additionalFeaturesButton.layer.cornerRadius = 17.5
        return additionalFeaturesButton
    }()
    
    private let swipeView: UIView = {
        let swipeView = UIView()
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 70/255, alpha: 1)
        swipeView.layer.cornerRadius = 2.5
        return swipeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: 47/255, green: 47/255, blue: 49/255, alpha: 1)
    }
    
    func setupUI() {
        view.addSubview(recordPlayerTrackImageView)
        view.addSubview(recordPlayerTrackNameLabel)
        view.addSubview(recordPlayerPerformerNameLabel)
        view.addSubview(trackSlider)
        view.addSubview(playPauseButton)
        view.addSubview(backwardButton)
        view.addSubview(forwardButton)
        view.addSubview(additionalFeaturesButton)
        view.addSubview(swipeView)
        
        recordPlayerTrackImageView.snp.makeConstraints { make in
            make.height.equalTo(350)
            make.width.equalTo(350)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(80)
        }
        
        recordPlayerTrackNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(40)
            make.top.equalTo(recordPlayerTrackImageView.snp.bottom).offset(50)
        }
        
        recordPlayerPerformerNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(40)
            make.top.equalTo(recordPlayerTrackNameLabel.snp.bottom).offset(10)
        }
        
        trackSlider.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(recordPlayerPerformerNameLabel.snp.bottom).offset(30)
            make.width.equalTo(350)
            make.height.equalTo(23)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(trackSlider.snp.bottom).offset(70)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        backwardButton.snp.makeConstraints { make in
            make.trailing.equalTo(playPauseButton.snp.leading).offset(-50)
            make.top.equalTo(trackSlider.snp.bottom).offset(70)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.leading.equalTo(playPauseButton.snp.trailing).offset(50)
            make.top.equalTo(trackSlider.snp.bottom).offset(70)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        additionalFeaturesButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-40)
            make.top.equalTo(recordPlayerTrackImageView.snp.bottom).offset(60)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        swipeView.snp.makeConstraints { make in
            make.bottom.equalTo(recordPlayerTrackImageView.snp.top).offset(-30)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(40)
            make.height.equalTo(5)
        }
    }
}

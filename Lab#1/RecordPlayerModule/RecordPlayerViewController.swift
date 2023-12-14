//
//  RecordPlayerViewController.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 23.11.2023.
//

import UIKit
import SnapKit
import AVFoundation

final class RecordPlayerViewController: UIViewController {
    
    private var tracks: [TracksModel]
    private var currentIndex: Int

    private var player: AVAudioPlayer?
    private var isPlaying = true
    private var currentTime: TimeInterval = 0.0
    private var totalTime: TimeInterval = 0.0
    private var playPauseIsTap = true
    
    private let recordPlayerTrackImageView: UIImageView = {
        let recordPlayerTrackImageView = UIImageView()
        recordPlayerTrackImageView.backgroundColor = .white
        recordPlayerTrackImageView.translatesAutoresizingMaskIntoConstraints = false
        recordPlayerTrackImageView.layer.cornerRadius = 10
        recordPlayerTrackImageView.clipsToBounds = true
        return recordPlayerTrackImageView
    }()
    
    private let recordPlayerTrackNameLabel: UILabel = {
        let recordPlayerTrackNameLabel = UILabel()
        recordPlayerTrackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recordPlayerTrackNameLabel.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        recordPlayerTrackNameLabel.textColor = .white
        return recordPlayerTrackNameLabel
    }()
    
    private let recordPlayerPerformerNameLabel: UILabel = {
        let recordPlayerPerformerNameLabel = UILabel()
        recordPlayerPerformerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recordPlayerPerformerNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        recordPlayerPerformerNameLabel.textColor = .white
        return recordPlayerPerformerNameLabel
    }()
    
    private let trackSlider: UISlider = {
        let trackSlider = UISlider()
        trackSlider.translatesAutoresizingMaskIntoConstraints = false
        trackSlider.minimumTrackTintColor = .darkGray
        trackSlider.maximumTrackTintColor = .darkGray
        trackSlider.thumbTintColor = .gray
        return trackSlider
    }()
    
    private lazy var playPauseButton: UIButton = {
        let playPauseButton = UIButton()
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause.fill" : "play.fill"), for: .normal)
        playPauseButton.addTarget(self, action: #selector(playPauseButtonIsTap), for: .touchUpInside)
        playPauseButton.tintColor = .white
        playPauseButton.imageView?.contentMode = .scaleAspectFit
        playPauseButton.contentVerticalAlignment = .fill
        playPauseButton.contentHorizontalAlignment = .fill
        return playPauseButton
    }()
    
    private let backwardButton: UIButton = {
        let backwardButton = UIButton()
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        backwardButton.tintColor = .white
        backwardButton.imageView?.contentMode = .scaleAspectFit
        backwardButton.contentVerticalAlignment = .fill
        backwardButton.contentHorizontalAlignment = .fill
        return backwardButton
    }()
    
    private let forwardButton: UIButton = {
        let forwardButton = UIButton()
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        forwardButton.tintColor = .white
        forwardButton.imageView?.contentMode = .scaleAspectFit
        forwardButton.contentVerticalAlignment = .fill
        forwardButton.contentHorizontalAlignment = .fill
        return forwardButton
    }()
    
    private let additionalFeaturesButton: UIButton = {
        let additionalFeaturesButton = UIButton()
        additionalFeaturesButton.translatesAutoresizingMaskIntoConstraints = false
        additionalFeaturesButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        additionalFeaturesButton.imageView?.contentMode = .scaleAspectFit
        additionalFeaturesButton.tintColor = .white
        additionalFeaturesButton.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 70/255, alpha: 1)
        additionalFeaturesButton.layer.cornerRadius = 17.5
        return additionalFeaturesButton
    }()
    
    private let leftTimeLabel: UILabel = {
        let leftTimeLabel = UILabel()
        leftTimeLabel.text = "0:00"
        leftTimeLabel.textColor = .lightGray
        leftTimeLabel.font = UIFont.systemFont(ofSize: 15)
        return leftTimeLabel
    }()
    
    private let rightTimeLabel: UILabel = {
        let rightTimeLabel = UILabel()
        rightTimeLabel.text = "0:00"
        rightTimeLabel.textColor = .lightGray
        rightTimeLabel.font = UIFont.systemFont(ofSize: 15)
        return rightTimeLabel
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
        configure()
        setupAudio()
        view.backgroundColor = UIColor(red: 47/255, green: 47/255, blue: 49/255, alpha: 1)
    }
    
    init(tracks: [TracksModel], currentIndex: Int) {
        self.tracks = tracks
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let track = tracks[currentIndex]
        recordPlayerTrackNameLabel.text = track.name
        recordPlayerPerformerNameLabel.text = track.artistName
        if let trackImage = track.image, let imageURL = URL(string: trackImage) {
            recordPlayerTrackImageView.kf.setImage(with: imageURL)
        }
    }
    
    private func setupAudio() {
        let track = tracks[currentIndex]
        guard let url = Bundle.main.url(forResource: track.audio, withExtension: "mp3")
        else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
        } catch {
            print("Errir loading audio: \(error)")
        }
    }
    
    private func playAudio() {
        player?.play()
        isPlaying = true
        print("Playing")
    }
    
    private func stopAudio() {
        player?.pause()
        isPlaying = false
        print("Paused")
    }
    
    @objc func playPauseButtonIsTap() {
        playPauseIsTap.toggle()
        if playPauseIsTap {
            playAudio()
            print("isPlayinfTrue")
        } else {
            stopAudio()
            print("isPlayinfFalse")
        }
    }
    
    private func setupUI() {
        view.addSubview(recordPlayerTrackImageView)
        view.addSubview(recordPlayerTrackNameLabel)
        view.addSubview(recordPlayerPerformerNameLabel)
        view.addSubview(trackSlider)
        view.addSubview(playPauseButton)
        view.addSubview(backwardButton)
        view.addSubview(forwardButton)
        view.addSubview(additionalFeaturesButton)
        view.addSubview(leftTimeLabel)
        view.addSubview(rightTimeLabel)
        view.addSubview(swipeView)
        
        recordPlayerTrackImageView.snp.makeConstraints { make in
            make.height.equalTo(350)
            make.width.equalTo(350)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(80)
        }
        
        recordPlayerTrackNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(40)
            make.trailing.equalTo(additionalFeaturesButton.snp.leading).offset(-20)
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
        
        leftTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(35)
            make.top.equalTo(trackSlider.snp.bottom).offset(5)
        }
        
        rightTimeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-35)
            make.top.equalTo(trackSlider.snp.bottom).offset(5)
        }
        
        swipeView.snp.makeConstraints { make in
            make.bottom.equalTo(recordPlayerTrackImageView.snp.top).offset(-30)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(40)
            make.height.equalTo(5)
        }
    }
}

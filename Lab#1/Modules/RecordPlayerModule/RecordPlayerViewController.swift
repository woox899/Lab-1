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
    private var player: AVPlayer?
    private var isPlaying = true
    private var playPauseIsTap = true
    private var viewModel: TrackListViewModelProtocol
    
    private let recordPlayerTrackImageView: UIImageView = {
        let recordPlayerTrackImageView = UIImageView()
        recordPlayerTrackImageView.backgroundColor = .white
        recordPlayerTrackImageView.layer.cornerRadius = 10
        recordPlayerTrackImageView.clipsToBounds = true
        return recordPlayerTrackImageView
    }()
    
    private let recordPlayerTrackNameLabel: UILabel = {
        let recordPlayerTrackNameLabel = UILabel()
        recordPlayerTrackNameLabel.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        recordPlayerTrackNameLabel.textColor = .white
        return recordPlayerTrackNameLabel
    }()
    
    private let recordPlayerPerformerNameLabel: UILabel = {
        let recordPlayerPerformerNameLabel = UILabel()
        recordPlayerPerformerNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        recordPlayerPerformerNameLabel.textColor = .white
        return recordPlayerPerformerNameLabel
    }()
    
    private lazy var trackSlider: UISlider = {
        let trackSlider = UISlider()
        trackSlider.minimumTrackTintColor = .darkGray
        trackSlider.maximumTrackTintColor = .darkGray
        trackSlider.thumbTintColor = .gray
        trackSlider.minimumValue = 0.0
        trackSlider.maximumValue = 1.0
        trackSlider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        return trackSlider
    }()
    
    private lazy var playPauseButton: UIButton = {
        let playPauseButton = UIButton()
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        playPauseButton.addTarget(self, action: #selector(playPauseButtonIsTap), for: .touchUpInside)
        playPauseButton.tintColor = .white
        playPauseButton.imageView?.contentMode = .scaleAspectFit
        playPauseButton.contentVerticalAlignment = .fill
        playPauseButton.contentHorizontalAlignment = .fill
        return playPauseButton
    }()
    
    private lazy var backwardButton: UIButton = {
        let backwardButton = UIButton()
        backwardButton.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        backwardButton.tintColor = .white
        backwardButton.imageView?.contentMode = .scaleAspectFit
        backwardButton.contentVerticalAlignment = .fill
        backwardButton.contentHorizontalAlignment = .fill
        backwardButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return backwardButton
    }()
    
    private lazy var forwardButton: UIButton = {
        let forwardButton = UIButton()
        forwardButton.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        forwardButton.tintColor = .white
        forwardButton.imageView?.contentMode = .scaleAspectFit
        forwardButton.contentVerticalAlignment = .fill
        forwardButton.contentHorizontalAlignment = .fill
        forwardButton.addTarget(self, action: #selector(forwardTapped), for: .touchUpInside)
        return forwardButton
    }()
    
    private let additionalFeaturesButton: UIButton = {
        let additionalFeaturesButton = UIButton()
        additionalFeaturesButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        additionalFeaturesButton.imageView?.contentMode = .scaleAspectFit
        additionalFeaturesButton.tintColor = .white
        additionalFeaturesButton.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 70/255, alpha: 1)
        additionalFeaturesButton.layer.cornerRadius = 17.5
        return additionalFeaturesButton
    }()
    
    private let leftTimeLabel: UILabel = {
        let leftTimeLabel = UILabel()
        leftTimeLabel.textColor = .lightGray
        leftTimeLabel.font = UIFont.systemFont(ofSize: 15)
        return leftTimeLabel
    }()
    
    private let rightTimeLabel: UILabel = {
        let rightTimeLabel = UILabel()
        rightTimeLabel.textColor = .lightGray
        rightTimeLabel.font = UIFont.systemFont(ofSize: 15)
        return rightTimeLabel
    }()
    
    private let swipeView: UIView = {
        let swipeView = UIView()
        swipeView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 70/255, alpha: 1)
        swipeView.layer.cornerRadius = 2.5
        return swipeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
        setupAudio()
    }
    
    init(viewModel: TrackListViewModelProtocol, tracks: [TracksModel], currentIndex: Int) {
        self.tracks = tracks
        self.currentIndex = currentIndex
        self.viewModel = viewModel
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
        guard let urlString = track.audio, let url = URL(string: urlString) else {
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        guard let player = try? AVPlayer(playerItem: playerItem) else { return }
        player.volume = 1.0
        self.player = player
        playAudio()
    }
    
    private func playAudio() {
        player?.play()
        isPlaying = true
        updateAudioPlayerSlider()
    }
    
    private func stopAudio() {
        player?.pause()
        isPlaying = false
    }
    
    @objc func playPauseButtonIsTap() {
        playPauseIsTap.toggle()
        if playPauseIsTap {
            playAudio()
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            stopAudio()
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc private func forwardTapped() {
        nextTrack(isForward: true)
    }
    
    @objc private func backTapped() {
        nextTrack(isForward: false)
    }
    
    private func nextTrack(isForward: Bool) {
        if isForward {
            currentIndex += 1
        } else {
            currentIndex -= 1
        }
        configure()
        setupAudio()
        //MARK: - Надо решить с кнопкой
        playPauseButtonIsTap()
    }
    
    func updateAudioPlayerSlider() {
        guard let player, isPlaying else { return }
        let currentTimeInSeconds = CMTimeGetSeconds(player.currentTime())
        let mins = currentTimeInSeconds / 60
        let secs = currentTimeInSeconds.truncatingRemainder(dividingBy: 60)
        let timeformatter = NumberFormatter()
        timeformatter.minimumIntegerDigits = 2
        timeformatter.minimumFractionDigits = 0
        timeformatter.roundingMode = .down
        guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else { return
        }
        
        leftTimeLabel.text = "\(minsStr):\(secsStr)"
        if let currentItem = player.currentItem {
            let duration = currentItem.duration
            if (CMTIME_IS_INVALID(duration)) {
                return
            }
            let currentTime = currentItem.currentTime()
            trackSlider.value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration))
            let durationTimeInSeconds = CMTimeGetSeconds(duration) - CMTimeGetSeconds(player.currentTime())
            if durationTimeInSeconds >= 0 {
                let durMins = durationTimeInSeconds / 60
                let durSec = durationTimeInSeconds.truncatingRemainder(dividingBy: 60)
                guard let minsDurStr = timeformatter.string(from: NSNumber(value: durMins)), let secsDurStr = timeformatter.string(from: NSNumber(value: durSec)) else { return
                }
                rightTimeLabel.text = " - \(minsDurStr):\(secsDurStr)"
            } else {
                rightTimeLabel.text = " - 00:00"
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.updateAudioPlayerSlider()
            }
        }
    }
    
    @objc func changeSlider() {
        guard let duration = player?.currentItem?.duration else { return }
        let currentTimeSliderPosition = Float(CMTimeGetSeconds(duration)) * trackSlider.value
        player?.seek(to: CMTime(value: CMTimeValue(currentTimeSliderPosition), timescale: 1))
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 47/255, green: 47/255, blue: 49/255, alpha: 1)
        
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
            make.height.equalTo(view.frame.height / 3)
            make.width.equalTo(recordPlayerTrackImageView.snp.height)
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
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
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

//
//  PlayerV2ViewController.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 05/04/22.
//

import UIKit
import AVFoundation
import AVKit
import SDWebImage

class PlayerV2ViewController: UIViewController {
    
    var episodeDetails: Episode?
    var isPlaying: Bool = true
    
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle( "Dismiss", for: .normal)
        button.addTarget(self, action: #selector(dissmissPresses), for: .touchUpInside)
        
        return button
    }()
    
    let trackImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        iv.image = UIImage(systemName: "photo")
        
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let playTimeSlider: UISlider = {
       let slider = UISlider()
       slider.value = 0.5
       return slider
   }()
    
    let playBackTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = "00:00:00"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = "00:00:00"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let volumeSlider: UISlider = {
       let slider = UISlider()
       slider.value = 0.5
       return slider
   }()
   
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
//        label.text = "Can't feel my face"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
   }()
   
   let subtitleLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 1
       label.textAlignment = .center
//       label.text = "The Weeknd"
       label.font = .systemFont(ofSize: 20, weight: .regular)
       label.textColor = .secondaryLabel
       return label
   }()
   
   let backButton: UIButton = {
       let button = UIButton()
       button.tintColor = .label
       let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
       button.setImage(image, for: .normal)
       return button
   }()
   
   let nextButton: UIButton = {
       let button = UIButton()
       button.tintColor = .label
       let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
       button.setImage(image, for: .normal)
       return button
   }()
   
   let playPauseButton: UIButton = {
       let button = UIButton()
       button.tintColor = .label
       let pause = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 37, weight: .regular))
       button.setImage(pause, for: .normal)
       button.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
       return button
   }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpViews()
        guard let episodeDetails = episodeDetails else {
            return
        }
        configure(with: episodeDetails)
        playEpisode()
    }
    
    @objc func dissmissPresses(){
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func playEpisode(){
        guard let url = URL(string: episodeDetails?.streamUrl ?? "") else{
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
}



extension PlayerV2ViewController{
    
    func setUpViews(){
        view.addSubview(dismissButton)
        view.addSubview(trackImageView)
        view.addSubview(playTimeSlider)
        view.addSubview(playBackTimeLabel)
        view.addSubview(remainingTimeLabel)
        view.addSubview(volumeSlider)
        view.addSubview(nameLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(backButton)
        view.addSubview(nextButton)
        view.addSubview(playPauseButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageHeight: CGFloat = 340
        dismissButton.frame = CGRect(x: view.frame.midX-50, y: 60, width: 100, height: 20)
        trackImageView.frame = CGRect(x: view.frame.midX - (imageHeight/2), y: dismissButton.frame.maxY+20, width: imageHeight, height: imageHeight)
        playTimeSlider.frame = CGRect(x: 20, y: trackImageView.frame.maxY+20, width: view.frame.width-40, height: 40)
        playBackTimeLabel.frame = CGRect(x: 20, y: playTimeSlider.frame.maxY, width: view.frame.width/2 - 20, height: 20)
        remainingTimeLabel.frame = CGRect(x: view.frame.midX, y: playTimeSlider.frame.maxY, width: view.frame.width/2 - 20, height: 20)
        nameLabel.frame = CGRect(x: 20, y: remainingTimeLabel.frame.maxY+20, width: view.frame.width-40, height: 30)
        subtitleLabel.frame = CGRect(x: 20, y: nameLabel.frame.maxY+20, width: view.frame.width-40, height: 30)
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(x: (view.frame.width-buttonSize)/2, y: subtitleLabel.frame.maxY + 20, width: buttonSize, height: buttonSize)
        backButton.frame = CGRect(x: (view.frame.width - buttonSize)/2 - 100, y: playPauseButton.frame.minY, width: buttonSize, height: buttonSize )
        nextButton.frame = CGRect(x: (view.frame.width - buttonSize)/2 + 100, y: playPauseButton.frame.minY, width: buttonSize, height: buttonSize )
        volumeSlider.frame = CGRect(x: 20, y: nextButton.frame.maxY+20, width: view.frame.width-40, height: 40)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            let totalSeconds = CMTimeGetSeconds(time)
            print(totalSeconds)
        }
    }
    
    func configure(with episode: Episode){
        trackImageView.sd_setImage(with: URL(string: episode.artworkUrl100 ?? ""), completed: nil)
        nameLabel.text = episode.title
        subtitleLabel.text = episode.author
    }
    
    @objc func didTapPlayPause(){
        if player.timeControlStatus == .paused{
            player.play()
            let pause = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 37, weight: .regular))
            playPauseButton.setImage(pause, for: .normal)
        }else{
            player.pause()
            let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 37, weight: .regular))
            playPauseButton.setImage(play, for: .normal)
            
        }
    }
}


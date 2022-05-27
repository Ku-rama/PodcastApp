//
//  PlayerViewController.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 30/03/22.
//

import UIKit
import SDWebImage
import AVKit

protocol PlayerViewControllerDelegate: AnyObject{
    func didTapPlayPause()
    func didTapNext()
    func didTapBack()
    func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController{
    
    weak var delegate: PlayerViewControllerDelegate?
    
    var episodeDetails: Episode?
    
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
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(trackImageView)
        view.addSubview(controlsView)
        view.addSubview(dismissButton)
        guard let episodeDetails = episodeDetails else {
            return
        }
        configure(with: episodeDetails)
        playEpisode()
        controlsView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        dismissButton.frame = CGRect(x: view.frame.midX-50, y: 60, width: 100, height: 30)
        let trackImageViewHeight: CGFloat = 300
        trackImageView.frame = CGRect(x: view.frame.midX - (trackImageViewHeight/2), y: dismissButton.frame.maxY + 30, width: trackImageViewHeight, height: trackImageViewHeight)
        controlsView.frame = CGRect(x: 0, y: trackImageView.frame.maxY+40, width: view.frame.width, height: view.frame.height - 60 - trackImageViewHeight-40)
    }
    
    @objc func dissmissPresses(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func configure(with episode: Episode){
        trackImageView.sd_setImage(with: URL(string: episode.artworkUrl100 ?? ""), completed: nil)
        
        controlsView.configure(with: episode)
    }
    
    fileprivate func playEpisode(){
        guard let url = URL(string: episodeDetails?.streamUrl ?? "") else{
            return
        }
        print("Trying to play episode at url: \(url)")
//        let playerItem = AVPlayerItem(url: url)
//        player.replaceCurrentItem(with: playerItem)
//        player.play()
    }
}

extension PlayerViewController: PlayerControlsViewDelegate{
    func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapPlayPause()
    }
    
    func playerControlsViewDidTapBack(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapBack()
    }
    
    func playerControlsViewDidTapNext(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapNext()
    }
    
    func playerControlsViewDidSlide(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
    
    
}

//
//  PlaybackPresentor.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 04/04/22.
//

import Foundation
import AVFoundation
import UIKit

protocol PlayerDataSource: AnyObject{
    var songName: String? {get}
    var subtitle: String? {get}
}


final class PlaybackPresentor: PlayerViewControllerDelegate{
    
    static let shared = PlaybackPresentor()
    
    private var episode: Episode?
    
    var index = 0
    
    var playerVC: PlayerViewController?
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    var curruntEpisode: Episode?{
        if let episode = episode {
            print("printing the episode \(episode)")
            return episode
        }
        return nil
    }
    
    func startPlayback(from viewController: UIViewController, episode: Episode){
        guard let url = URL(string: episode.streamUrl ?? "") else{
            print("URL is nil.")
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        self.episode = episode
        print("This is the episode \(episode)")
        let vc = PlayerViewController()
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true){
            [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing{
                player.pause()
            }else if player.timeControlStatus == .paused{
                player.play()
            }
        }
    }
    
    func didTapNext() {
        print("Next is Tapped.")
    }
    
    func didTapBack() {
        print("Back is Tapped.")
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}

extension PlaybackPresentor: PlayerDataSource{
    
    
    var songName: String?{
        return curruntEpisode?.title
    }
    
    var subtitle: String?{
        return curruntEpisode?.author
    }
}


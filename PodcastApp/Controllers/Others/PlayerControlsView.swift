//
//  ControlsView.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 30/03/22.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject{
    func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBack(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapNext(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidSlide(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}


final class PlayerControlsView: UIView{
    
    private var isPlaying = true
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let playTimeSlider: UISlider = {
       let slider = UISlider()
       slider.value = 0.5
       return slider
   }()
    
    private let playBackTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = "00:00:00"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private let remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = "00:00:00"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private let volumeSlider: UISlider = {
       let slider = UISlider()
       slider.value = 0.5
       return slider
   }()
   
   private let nameLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 1
       label.textAlignment = .center
       label.font = .systemFont(ofSize: 20, weight: .semibold)
       return label
   }()
   
   private let subtitleLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 1
       label.textAlignment = .center
       label.font = .systemFont(ofSize: 20, weight: .regular)
       label.textColor = .secondaryLabel
       return label
   }()
   
   private let backButton: UIButton = {
       let button = UIButton()
       button.tintColor = .label
       let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
       
       button.setImage(image, for: .normal)
       return button
   }()
   
   private let nextButton: UIButton = {
       let button = UIButton()
       button.tintColor = .label
       let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
       
       button.setImage(image, for: .normal)
       return button
   }()
   
   private let playPauseButton: UIButton = {
       let button = UIButton()
       button.tintColor = .label
       let image = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 37, weight: .regular))
       button.setImage(image, for: .normal)
       return button
   }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addSubview(nameLabel)
        addSubview(volumeSlider)
        addSubview(nextButton)
        addSubview(backButton)
        addSubview(playPauseButton)
        addSubview(subtitleLabel)
        addSubview(playTimeSlider)
        addSubview(playBackTimeLabel)
        addSubview(remainingTimeLabel)
        clipsToBounds = true
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        
    }
    
    @objc private func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        delegate?.playerControlsViewDidSlide(self, didSlideSlider: value)
    }
    
    @objc private func didTapBack(){
        delegate?.playerControlsViewDidTapBack(self)
    }
    
    @objc private func didTapNext(){
        delegate?.playerControlsViewDidTapNext(self)
    }
    
    @objc private func didTapPlayPause(){
        delegate?.playerControlsViewDidTapPlayPause(self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = CGRect(x: 0, y: 20, width: frame.width, height: 30)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.frame.maxY+10, width: frame.width, height: 30)
        playTimeSlider.frame = CGRect(x: 10, y: subtitleLabel.frame.maxY+20, width: frame.width-20, height: 30)
        playBackTimeLabel.frame = CGRect(x: 10, y: playTimeSlider.frame.maxY, width: 100, height: 15)
        remainingTimeLabel.frame = CGRect(x: frame.width-110, y: playTimeSlider.frame.maxY, width: 100, height: 15)
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(x: (frame.width-buttonSize)/2, y: playBackTimeLabel.frame.maxY + 20, width: buttonSize, height: buttonSize)
        backButton.frame = CGRect(x: (frame.width - buttonSize)/2 - 100, y: playPauseButton.frame.minY, width: buttonSize, height: buttonSize )
        nextButton.frame = CGRect(x: (frame.width - buttonSize)/2 + 100, y: playPauseButton.frame.minY, width: buttonSize, height: buttonSize )
        volumeSlider.frame = CGRect(x: 10, y: nextButton.frame.maxY+20, width: frame.width-20, height: 30)
    }
    
    func configure(with episode: Episode){
        nameLabel.text = episode.title
        subtitleLabel.text = episode.author
    }
    
    
}

//
//  EpisodeTableViewCell.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 28/03/22.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EpisodeCollectionViewCell"
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Tuesday"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    var trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    var descriptoonLabel: UILabel = {
        let label = UILabel()
        label.text = "Discription"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    var trackTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(dateLabel)
        addSubview(trackNameLabel)
        addSubview(descriptoonLabel)
        addSubview(playButton)
        addSubview(trackTimeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.frame = CGRect(x: 10, y: 10, width: 200, height: 15)
        trackNameLabel.frame = CGRect(x: 10, y: dateLabel.frame.maxY + 10, width: frame.width-20, height: 40)
        descriptoonLabel.frame = CGRect(x: 10, y: trackNameLabel.frame.maxY + 10, width: frame.width-20, height: 60)
        playButton.frame = CGRect(x: 10, y: descriptoonLabel.frame.maxY + 10, width: 20, height: 20)
        trackTimeLabel.frame = CGRect(x: playButton.frame.maxX+10, y: descriptoonLabel.frame.maxY+10, width: 200, height: 20)
//
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}

//
//  EpisodeHeaderCollectionReusableView.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 29/03/22.
//

import UIKit

final class EpisodeHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "EpisodeHeaderCollectionReusableView"
    
    let podcastImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let podcastTile: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let artistName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("Play All", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    let podcastCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .ultraLight)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(podcastImageView)
        addSubview(podcastTile)
        addSubview(artistName)
        addSubview(playButton)
        addSubview(podcastCategoryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageHeight = 160
        let center = (Int(frame.size.width / 2)) - (imageHeight/2)
        podcastImageView.frame = CGRect(x: center, y: 20, width: imageHeight, height: imageHeight)
        podcastTile.frame = CGRect(x: 20, y: podcastImageView.frame.maxY + 10, width: frame.width - 40, height: 20)
        artistName.frame = CGRect(x: 20, y: podcastTile.frame.maxY + 5, width: frame.width - 40, height: 20)
        playButton.frame = CGRect(x: 90, y: artistName.frame.maxY+10, width: frame.width - 180, height: 40)
        
        podcastCategoryLabel.frame = CGRect(x: 12, y: playButton.frame.maxY+10, width: frame.width-24, height: 20)
    }
    
    func configure(with model: EpisodeHeaderViewModel){
        podcastImageView.sd_setImage(with: URL(string: model.artworkUrl ?? ""), completed: nil)
        podcastTile.text = model.title
        artistName.text = model.author
        podcastCategoryLabel.text = model.podcastCategory
    }
    
}

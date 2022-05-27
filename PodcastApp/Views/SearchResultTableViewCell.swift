//
//  SearchResultTableViewCell.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 27/03/22.
//

import UIKit
import SDWebImage


class SearchResultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultTableViewCell"
    
    var trackNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(iconImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = CGRect(x: 10, y: 0, width: contentView.frame.height-5, height: contentView.frame.height-5)
        iconImageView.layer.cornerRadius = (contentView.frame.height-5)/2
        iconImageView.layer.masksToBounds = true
        trackNameLabel.frame = CGRect(x: iconImageView.frame.maxX+10, y: 10, width: contentView.frame.width-20-iconImageView.frame.width, height: 20)
        artistNameLabel.frame = CGRect(x: iconImageView.frame.maxX+10, y: trackNameLabel.frame.maxY+10, width: contentView.frame.width-20-iconImageView.frame.width, height: 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        iconImageView.image = nil
    }
    
    func configure(with model: Podcast){
        trackNameLabel.text = model.trackName
        artistNameLabel.text = model.artistName
        iconImageView.sd_setImage(with: URL(string: model.artworkUrl100 ?? ""), completed: nil)
    }
    

}

//
//  TitleHeaderCollectionReusableView.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 26/03/22.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "TitleHeaderCollectionReusableView"
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(seeAllPressed), for: .touchUpInside)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.backgroundColor = .systemBackground
        addSubview(label)
        addSubview(secondaryLabel)
        addSubview(seeAllButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 14, y: 0, width: frame.width - 100, height: frame.height/2)
        secondaryLabel.frame = CGRect(x: 14, y: label.frame.maxY, width: frame.width-100, height: frame.height/2)
        seeAllButton.frame = CGRect(x: frame.width - 90, y: 0, width: 80, height: 40)
        label.text = "You Might Like"
        secondaryLabel.text = "Based on your listening"
        label.textColor = UIColor.white
    }
    
    @objc func seeAllPressed(){
        print("Button is pressed")
    }
    
}

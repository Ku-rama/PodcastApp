//
//  BlankViewController.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 14/02/22.
//

import UIKit

class BlankViewController: UIViewController{
    
    
    var textLabel: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .gray
        tf.text = "Shweta.yagnik_cehod@ljku.edu.in"
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = UIColor(red: 21/255, green: 21/255, blue: 22/255, alpha: 1.00)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

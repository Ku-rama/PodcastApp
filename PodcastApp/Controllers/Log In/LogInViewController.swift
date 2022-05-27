//
//  LogInViewController.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 26/03/22.
//

import UIKit
import AuthenticationServices

class LogInViewController: UIViewController {
    
    
    private let emailTextFIeld: TextField = {
        let tf = TextField()
        tf.placeholder = "Email"
        let myColor = UIColor.white
        tf.layer.borderColor = myColor.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let  passwordTextFiels: TextField = {
        let tf = TextField()
        let myColor = UIColor.white
        tf.layer.borderColor = myColor.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        tf.placeholder = "Password"
        return tf
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setTitle("Sign In", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(emailTextFIeld)
        view.addSubview(passwordTextFiels)
        view.addSubview(signInButton)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailTextFIeld.frame = CGRect(x: 10, y: 200, width: view.frame.width - 20, height: 40)
        passwordTextFiels.frame = CGRect(x: emailTextFIeld.frame.minX, y: emailTextFIeld.frame.maxY + 10, width: view.frame.width - 20, height: 40)
        signInButton.frame = CGRect(x: emailTextFIeld.frame.minX, y: passwordTextFiels.frame.maxY + 10, width: view.frame.width - 20, height: 40)
    }
}


class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

//
//  MainTabBarController.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 04/02/22.
//

import UIKit

class MainTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    
    //MARK:- Setup Controller Here
    
    func setupViewController(){
        UINavigationBar.appearance().prefersLargeTitles = true
        
        tabBar.tintColor = .purple
        
        viewControllers = [
            generateNavigationController(with: podcstSearchController(), title: "Search", image: UIImage(named: "search")!),
            generateNavigationController(with: ViewController(), title: "Favorites", image: UIImage(named: "favorites")!),
            generateNavigationController(with: ViewController(), title: "Downloads", image: UIImage(named: "downloads")!)
        ]
    }
    
    
    //MARK:- Helper Functions
    
    fileprivate func generateNavigationController(with rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController{
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    
}

//
//  TabBarViewController.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 26/03/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = ListenNowViewController()
        let vc2 = BrowseViewController()
        let vc3 = LibraryViewController()
        let vc4 = SearchViewController()
        
        vc1.title = "Listen Now"
        vc2.title = "Browse"
        vc3.title = "Library"
        vc4.title = "Search"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        vc4.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc4)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc1)
        
        nav1.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        nav1.navigationBar.prefersLargeTitles = true
        nav1.navigationBar.tintColor = .label
        nav2.tabBarItem = UITabBarItem(title: "Browse", image: UIImage(systemName: "square.grid.2x2.fill"), tag: 2)
        nav2.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.tintColor = .label
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "square.stack.fill"), tag: 3)
        nav3.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.tintColor = .label
        nav4.tabBarItem = UITabBarItem(title: "Listen Now", image: UIImage(systemName: "play.circle.fill"), tag: 4)
        nav4.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.tintColor = .label
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
        
    }
    

}

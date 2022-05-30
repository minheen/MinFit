//
//  MainTabBarController.swift
//  MinFit
//
//  Created by 노민희 on 2022/05/17.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reactor = LibraryViewReactor()
        let libraryVC = LibraryViewController(reactor: reactor)
        libraryVC.title = "라이브러리"
        libraryVC.tabBarItem.image = UIImage(named: "library")
        
        setViewControllers([libraryVC], animated: false)
    }
}

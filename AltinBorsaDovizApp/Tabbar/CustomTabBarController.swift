//
//  CustomTabBarController.swift
//  AltinBorsaDovizApp
//
//  Created by Metehan Karadeniz on 8.06.2023.
//

import UIKit
import UIKit

class CustomTabBarController: UITabBarController {

    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        object_setClass(self.tabBar, CustomTabBar.self)
        
    }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = HomeViewController()
        let personViewController = PersonViewController()
     
        
        self.setViewControllers([homeViewController,personViewController], animated: true)
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["house.fill","person.fill"]
        
       for x in 0...1 {
          items[x].image = UIImage(systemName: images[x])
        }
        //self.tabBar.shadowImage = UIImage()
        //self.tabBar.backgroundImage = UIImage()
        self.tabBar.backgroundColor = .white
        self.selectedIndex = 0

        
    //    mapViewController.tabBarItem.selectedImage = UIImage(named: "Image 9")
    //    settingsViewController.tabBarItem.selectedImage = UIImage(named: "Image 10")
    }
    
    
    
}



//
//  MainTabBarViewController.swift
//  Project7-We-petition
//
//  Created by Lucas Maniero on 20/02/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    let tabBarIcons: [UITabBarItem] = {
        let newsItem = UITabBarItem(title: "Petitions", image: .init(systemName: "newspaper"), tag: 0)
        let settingsItem = UITabBarItem(title: "Top Rated", image: .init(systemName: "list.star"), tag: 1)
        return [newsItem, settingsItem]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let petitionsViewController = UINavigationController(rootViewController: PetitionsTableViewController())
        let settingsViewController = UINavigationController(rootViewController: PetitionsTableViewController())
        self.setViewControllers([petitionsViewController, settingsViewController], animated: false)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        
        if let vcs = viewControllers, vcs.count == tabBarIcons.count {
            vcs.enumerated().forEach({ (index, controller) in
                controller.tabBarItem = tabBarIcons[index]
            })
        }
    }
    

    
    

}

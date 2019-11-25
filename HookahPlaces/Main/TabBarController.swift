//
//  TabBarViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 26/08/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    private lazy var mainViewController: UIViewController = {
        return NavigationController(rootViewController: MainViewController())
    }()
    
    private lazy var searchViewController: UIViewController = {
        return NavigationController(rootViewController: SearchViewController())
    }()
    
    private lazy var settingsViewController: UIViewController = {
        return NavigationController(rootViewController: SettingsViewController())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension TabBarController {
    private func configure() {
        tabBar.tintColor = .black
        viewControllers = [mainViewController, searchViewController, settingsViewController]
        viewControllers?[0].tabBarItem = UITabBarItem(title: "Main", image: #imageLiteral(resourceName: "home"), tag: 0)
        viewControllers?[1].tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "search"), tag: 1)
        viewControllers?[2].tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "services"), tag: 2)
    }
}

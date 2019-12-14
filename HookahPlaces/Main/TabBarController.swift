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
    
    private lazy var profileViewController: UIViewController = {
        return NavigationController(rootViewController: ProfileViewController())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension TabBarController {
    private func configure() {
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        viewControllers = [mainViewController, searchViewController, profileViewController]
        setTabBarItems()
    }
    
    private func setTabBarItems() {
        viewControllers?[0].tabBarItem = UITabBarItem(title: "Главная", image: #imageLiteral(resourceName: "home"), tag: 0)
        viewControllers?[1].tabBarItem = UITabBarItem(title: "Поиск", image: #imageLiteral(resourceName: "search"), tag: 1)
        viewControllers?[2].tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "user_male"), tag: 2)
    }
}

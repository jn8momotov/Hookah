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
        setViewControllers()
    }
}

extension TabBarController {
    private func setViewControllers() {
        viewControllers = [mainViewController, searchViewController, settingsViewController]
    }
}

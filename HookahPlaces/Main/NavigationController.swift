//
//  MainNavigationViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 29/08/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension NavigationController {
    private func configure() {
        navigationBar.tintColor = .white
    }
}

//
//  SettingsViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
    private var presenter: SettingsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SettingsPresenter(view: self)
        configureView()
    }
}

extension SettingsViewController {
    private func configureView() {
        title = "Settings"
        view.backgroundColor = .groupTableViewBackground
    }
}

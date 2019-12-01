//
//  ProfileViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    private var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenter(view: self)
        configureView()
    }
}

extension ProfileViewController {
    private func configureView() {
        title = "Profile"
        view.backgroundColor = .groupTableViewBackground
    }
}

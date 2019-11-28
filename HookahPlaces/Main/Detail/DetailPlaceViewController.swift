//
//  DetailPlaceViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 28/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class DetailPlaceViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

extension DetailPlaceViewController {
    private func configureView() {
        view.backgroundColor = .white
    }
}

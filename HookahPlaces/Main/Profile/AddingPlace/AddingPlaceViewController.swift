//
//  AddingPlaceViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 15/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class AddingPlaceViewController: UIViewController {
    private var presenter: AddingPlacePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddingPlacePresenterImpl(view: self)
        configureView()
    }
}

extension AddingPlaceViewController {
    private func configureView() {
        
    }
}

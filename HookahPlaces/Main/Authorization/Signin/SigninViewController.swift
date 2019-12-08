//
//  SigninViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 08/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class SigninViewController: UIViewController {
    private var presenter: SigninPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SigninPresenter(view: self)
        configureView()
    }
}

extension SigninViewController {
    private func configureView() {
        title = "Вход"
        view.backgroundColor = .white
    }
}

//
//  SigninCoordinator.swift
//  HookahPlaces
//
//  Created by Евгений on 22/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SigninCoordinator {
    func dismiss()
    func showError(_ error: String)
    func showSignUp()
}

final class SigninCoordinatorImpl: SigninCoordinator {
    weak var view: SigninViewController?
    
    init(view: SigninViewController) {
        self.view = view
    }
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func showError(_ error: String) {
        view?.showAlert(title: "Ошибка", description: error)
    }
    
    func showSignUp() {
        view?.push(SignupViewController())
    }
}

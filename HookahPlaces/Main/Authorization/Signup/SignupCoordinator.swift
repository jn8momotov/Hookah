//
//  SignupCoordinator.swift
//  HookahPlaces
//
//  Created by Евгений on 21/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SignupCoordinator {
    func dismiss()
    func showError(_ error: String)
}

final class SignupCoordinatorImpl: SignupCoordinator {
    weak var view: SignupViewController?
    
    init(view: SignupViewController) {
        self.view = view
    }
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func showError(_ error: String) {
        view?.showAlert(title: "Ошибка", description: error)
    }
}

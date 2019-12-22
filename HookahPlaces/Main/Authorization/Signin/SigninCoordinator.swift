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
    func showSuccess()
    func showError(_ error: String)
}

final class SigninCoordinatorImpl: SigninCoordinator {
    weak var view: SigninViewController?
    
    init(view: SigninViewController) {
        self.view = view
    }
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func showSuccess() {
        view?.showAlert(title: "Успешно", description: "Вы успешно авторизовались!", completion: { [weak self] in
            self?.dismiss()
        })
    }
    
    func showError(_ error: String) {
        view?.showAlert(title: "Ошибка", description: error)
    }
}

//
//  SigninPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 08/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SigninPresenterProtocol {
    func signIn(email: String, password: String)
}

final class SigninPresenter: SigninPresenterProtocol {
    weak var view: SigninViewController?
    private let coordinator: SigninCoordinator
    private let authService: AuthorizationService = AuthorizationServiceImpl()
    
    init(view: SigninViewController) {
        self.view = view
        self.coordinator = SigninCoordinatorImpl(view: view)
    }
    
    func signIn(email: String, password: String) {
        authService.signIn(email: email, password: password, onError: { [weak self] error in
            self?.coordinator.showError(error)
        }, onSuccess: { [weak self] in
            self?.coordinator.showSuccess()
        })
    }
}

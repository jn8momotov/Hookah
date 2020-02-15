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
    func showSignUp()
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
        let model = SignInModel(email: email, password: password)
        authService.signIn(model, onError: { [weak self] error in
            self?.coordinator.showError(error)
        }, onSuccess: { [weak self] in
            NotificationCenter.default.post(name: .signIn, object: nil)
            self?.coordinator.dismiss()
        })
    }
    
    func showSignUp() {
        coordinator.showSignUp()
    }
}

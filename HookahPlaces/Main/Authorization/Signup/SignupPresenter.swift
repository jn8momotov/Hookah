//
//  SignupPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 08/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SignupPresenterProtocol {
    func signUp(email: String, password: String)
}

final class SignupPresenter: SignupPresenterProtocol {
    weak var view: SignupViewController?
    private let coordinator: SignupCoordinator
    private let authService: AuthorizationService = AuthorizationServiceImpl()
    
    init(view: SignupViewController) {
        self.view = view
        self.coordinator = SignupCoordinatorImpl(view: view)
    }
    
    func signUp(email: String, password: String) {
        authService.signUp(email: email, password: password, onError: { [weak self] error in
            self?.coordinator.showError(error)
        }, onSuccess: { [weak self] in
            self?.coordinator.showSuccess()
        })
    }
}

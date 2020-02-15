//
//  SignupPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 08/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SignupPresenterProtocol {
    func signUp(_ model: SignUpModel)
}

final class SignupPresenter: SignupPresenterProtocol {
    weak var view: SignupViewController?
    private let coordinator: SignupCoordinator
    private let authService: AuthorizationService = AuthorizationServiceImpl()
    
    init(view: SignupViewController) {
        self.view = view
        self.coordinator = SignupCoordinatorImpl(view: view)
    }
    
    func signUp(_ model: SignUpModel) {
        guard let correctModel = correctModel(model) else {
            return
        }
        authService.signUp(correctModel, onError: { [weak self] error in
            self?.coordinator.showError(error)
        }, onSuccess: { [weak self] in
            NotificationCenter.default.post(name: .signIn, object: nil)
            self?.coordinator.dismiss()
        })
    }
}

extension SignupPresenter {
    private func correctModel(_ model: SignUpModel) -> SignUpModel? {
        guard isCorrectName(model.name) else {
            coordinator.showError("Заполните имя!")
            return nil
        }
        guard isCorrectEmail(model.signInModel.email) else {
            coordinator.showError("Заполните корректно email!")
            return nil
        }
        guard let phone = isCorrectPhone(model.phone) else {
            coordinator.showError("Заполните корректно номер телефона!")
            return nil
        }
        guard isCorrectPassword(model.signInModel.password) else {
            coordinator.showError("Пароль должен быть не менеe 6 символов!")
            return nil
        }
        guard model.isAccept else {
            coordinator.showError("Необходимо принять пользовательское соглашение!")
            return nil
        }
        return SignUpModel(isAccept: model.isAccept,
                           photo: model.photo,
                           name: model.name,
                           phone: phone,
                           signInModel: model.signInModel)
    }
    
    private func isCorrectEmail(_ email: String) -> Bool {
        return isCorrect(email, for: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,64}")
    }
    
    private func isCorrectPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    private func isCorrectName(_ name: String) -> Bool {
        return !name.isEmpty
    }
    
    private func isCorrectPhone(_ phone: String) -> String? {
        guard let phoneNumber = numberPhoneFormat(phone) else {
            return nil
        }
        return isCorrect(phoneNumber, for: "79\\d{9}") ? phoneNumber : nil
    }
}

extension SignupPresenter {
    private func isCorrect(_ value: String, for template: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", template)
        return predicate.evaluate(with: value)
    }

    private func numberPhoneFormat(_ phone: String) -> String? {
        guard phone.count > 2 else {
            return nil
        }
        var phoneNumber: String = "7"
        switch phone[0] {
        case "+":
            if phone[1] == "7" {
                phoneNumber += String(phone[2..<phone.count])
            }
        case "7", "8":
            phoneNumber += String(phone[1..<phone.count])
        case "9":
            phoneNumber += phone
        default:
            return phoneNumber
        }
        return phoneNumber
    }
}

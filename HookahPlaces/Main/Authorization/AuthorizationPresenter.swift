//
//  AuthorizationPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 08/03/2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import Foundation

protocol AuthorizationPresenter {
    func didTapDone(phoneNumber: String, codeSMS: String)
    func isCorrectPhone(_ phone: String) -> String?
}

final class AuthorizationPresenterImpl: AuthorizationPresenter {
    private weak var view: AuthorizationViewController?
    private let authService: AuthorizationService = AuthorizationServiceImpl()
    
    private var verificationID: String = ""
    private var phoneNumberIsVerify: Bool = false
    
    init(view: AuthorizationViewController) {
        self.view = view
    }
    
    func didTapDone(phoneNumber: String, codeSMS: String) {
        phoneNumberIsVerify ? signIn(codeSMS) : verify(phoneNumber)
    }
    
    func isCorrectPhone(_ phone: String) -> String? {
        guard let phoneNumber = numberPhoneFormat(phone) else {
            return nil
        }
        return isCorrect(phoneNumber, for: "79\\d{9}") ? phoneNumber : nil
    }
}

extension AuthorizationPresenterImpl {
    private func verify(_ phoneNumber: String) {
        authService.verifyPhoneNumber(phoneNumber, onError: { [weak self] error in
            self?.view?.showAlert(title: "Ошибка!", description: error)
            self?.phoneNumberIsVerify = false
        }, onSuccess: { [weak self] verificationID in
            self?.verificationID = verificationID
            self?.phoneNumberIsVerify = true
            self?.view?.updateViewAfterVerifyPhoneNumber()
        })
    }
    
    private func signIn(_ codeSMS: String) {
        let verificationModel = VerificationModel(id: verificationID, code: codeSMS)
        authService.signIn(verificationModel, onError: { [weak self] error in
            self?.view?.showAlert(title: "Ошибка!", description: error)
        }, onSuccess: { [weak self] in
            self?.view?.dismiss(animated: true, completion: nil)
        })
    }
    
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

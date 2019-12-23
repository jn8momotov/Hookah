//
//  AuthorizationService.swift
//  HookahPlaces
//
//  Created by Евгений on 21/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

typealias ErrorHandler = (String) -> Void
typealias SuccessHandler = () -> Void
typealias AuthHandler = (result: AuthDataResult?, error: Error?, onError: ErrorHandler?, onSuccess: SuccessHandler?)

protocol AuthorizationService {
    static var currentUser: User? { get }
    func signIn(_ model: SignInModel, onError: ErrorHandler?, onSuccess: SuccessHandler?)
    func signUp(_ model: SignUpModel, onError: ErrorHandler?, onSuccess: SuccessHandler?)
    func signOut(onError: ErrorHandler?, onSuccess: SuccessHandler?)
}

extension AuthorizationService {
    static var currentUser: User? {
        return Auth.auth().currentUser
    }
}

final class AuthorizationServiceImpl: AuthorizationService {
    func signIn(_ model: SignInModel, onError: ErrorHandler?, onSuccess: SuccessHandler?) {
        Auth.auth().signIn(withEmail: model.email, password: model.password) { [weak self] result, error in
            let handler = (result: result, error: error, onError: onError, onSuccess: onSuccess)
            self?.completion(handler)
        }
    }
    
    func signUp(_ model: SignUpModel, onError: ErrorHandler?, onSuccess: SuccessHandler?) {
        let signIn = model.signInModel
        Auth.auth().createUser(withEmail: signIn.email, password: signIn.password) { [weak self] result, error in
            guard let user = result?.user, error == nil else {
                let textError = error?.localizedDescription ?? "Не удалось зарегистрироваться"
                onError?(textError)
                return
            }
            self?.sendUserData(model: model, uid: user.uid, onError: onError, onSuccess: onSuccess)
        }
    }
    
    func signOut(onError: ErrorHandler?, onSuccess: SuccessHandler?) {
        do {
            try Auth.auth().signOut()
            onSuccess?()
        } catch let error {
            onError?(error.localizedDescription)
        }
    }
}

extension AuthorizationServiceImpl {
    private func completion(_ completion: AuthHandler) {
        print("Authorization...........................")
        print("User: \(String(describing: completion.result?.user))")
        print("Error: \(String(describing: completion.error))")
        print("........................................")
        if let error = completion.error {
            completion.onError?(error.localizedDescription)
            return
        }
        guard let _ = completion.result else {
            completion.onError?("Unknown error")
            return
        }
        completion.onSuccess?()
    }
    
    private func sendUserData(model: SignUpModel, uid: String, onError: ErrorHandler?, onSuccess: SuccessHandler?) {
        let data = [
            "name": model.name,
            "phone": model.phone
        ]
        Firestore.firestore().collection("users").document(uid).setData(data) { error in
            if let error = error {
                onError?(error.localizedDescription)
                return
            }
            onSuccess?()
        }
    }
}

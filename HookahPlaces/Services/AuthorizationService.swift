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

protocol AuthorizationService: class {
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
    private let firestoreService: FirestoreService = FirestoreServiceImpl()
    
    func signIn(_ model: SignInModel, onError: ErrorHandler?, onSuccess: SuccessHandler?) {
        Auth.auth().signIn(withEmail: model.email, password: model.password) { [weak self] result, error in
            guard let user = result?.user, error == nil else {
                let textError = error?.localizedDescription ?? "Не удалось авторизоваться!"
                onError?(textError)
                return
            }
            self?.pullUserData(user: user, onError: onError, onSuccess: onSuccess)
        }
    }
    
    func signUp(_ model: SignUpModel, onError: ErrorHandler?, onSuccess: SuccessHandler?) {
        let signIn = model.signInModel
        Auth.auth().createUser(withEmail: signIn.email, password: signIn.password) { [weak self] result, error in
            guard let user = result?.user, error == nil else {
                let textError = error?.localizedDescription ?? "Не удалось зарегистрироваться!"
                onError?(textError)
                return
            }
            self?.pushUserData(user: user, name: model.name, phone: model.phone, onError: onError, onSuccess: onSuccess)
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
    private func pullUserData(user: User, onError: ErrorHandler?, onSuccess: SuccessHandler?) {
        firestoreService.pull(uid: user.uid, onError: onError) { [weak self] name, phone in
            DispatchQueue.main.async {
                self?.saveUserData(user: user, name: name, phone: phone)
                onSuccess?()
            }
        }
    }
    
    private func pushUserData(user: User, name: String, phone: String, onError: ErrorHandler?, onSuccess: SuccessHandler?) {
        firestoreService.push(uid: user.uid, name: name, phone: phone, onError: onError) { [weak self] in
            DispatchQueue.main.async {
                self?.saveUserData(user: user, name: name, phone: phone)
                onSuccess?()
            }
        }
    }
    
    private func saveUserData(user: User, name: String, phone: String) {
        if let profile = RealmService.shared.get(Profile.self).first {
            RealmService.shared.edit {
                profile.name = name
                profile.phone = phone
                profile.email = user.email ?? ""
            }
        } else {
            let profile = Profile()
            profile.name = name
            profile.phone = phone
            profile.email = user.email ?? ""
            RealmService.shared.save(profile)
        }
    }
}

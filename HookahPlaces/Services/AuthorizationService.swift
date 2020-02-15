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

typealias AuthHandler = (result: AuthDataResult?, error: Error?, onError: ErrorHandler?, onSuccess: VoidHandler?)

protocol AuthorizationService: class {
    static var currentUser: User? { get }
    func signIn(_ model: SignInModel, onError: ErrorHandler?, onSuccess: VoidHandler?)
    func signUp(_ model: SignUpModel, onError: ErrorHandler?, onSuccess: VoidHandler?)
    func signOut(onError: ErrorHandler?, onSuccess: VoidHandler?)
}

extension AuthorizationService {
    static var currentUser: User? {
        return Auth.auth().currentUser
    }
}

final class AuthorizationServiceImpl: AuthorizationService {
    private let firestoreService: FirestoreService = FirestoreServiceImpl()
    private let storageService: StorageService = StorageServiceImpl()
    
    func signIn(_ model: SignInModel, onError: ErrorHandler?, onSuccess: VoidHandler?) {
        Auth.auth().signIn(withEmail: model.email, password: model.password) { [weak self] result, error in
            guard let user = result?.user, error == nil else {
                let textError = error?.localizedDescription ?? "Не удалось авторизоваться!"
                onError?(textError)
                return
            }
            self?.pullUserData(user: user, onError: onError, onSuccess: onSuccess)
        }
    }
    
    func signUp(_ model: SignUpModel, onError: ErrorHandler?, onSuccess: VoidHandler?) {
        let signIn = model.signInModel
        Auth.auth().createUser(withEmail: signIn.email, password: signIn.password) { [weak self] result, error in
            guard let user = result?.user, error == nil else {
                let textError = error?.localizedDescription ?? "Не удалось зарегистрироваться!"
                onError?(textError)
                return
            }
            self?.pushUserData(user: user,
                               name: model.name,
                               phone: model.phone,
                               dataImage: model.photo,
                               onError: onError,
                               onSuccess: onSuccess)
        }
    }
    
    func signOut(onError: ErrorHandler?, onSuccess: VoidHandler?) {
        do {
            try Auth.auth().signOut()
            onSuccess?()
        } catch let error {
            onError?(error.localizedDescription)
        }
    }
}

extension AuthorizationServiceImpl {
    private func pullUserData(user: User, onError: ErrorHandler?, onSuccess: VoidHandler?) {
        var userName: String = ""
        var userPhone: String = ""
        var userDataImage: Data?
        
        let group = DispatchGroup()
        
        group.enter()
        firestoreService.pull(uid: user.uid, onError: onError) { name, phone in
            userName = name
            userPhone = phone
            group.leave()
        }
        
        group.enter()
        storageService.download(
            onSuccess: { dataImage in
                userDataImage = dataImage
                group.leave()
            }, onError: { error in
                group.leave()
            }
        )
        
        group.notify(queue: .main) { [weak self] in
            self?.saveUserData(user: user, name: userName, phone: userPhone, imageData: userDataImage)
            onSuccess?()
        }
    }
    
    private func pushUserData(user: User, name: String, phone: String, dataImage: Data?, onError: ErrorHandler?, onSuccess: VoidHandler?) {
        let group = DispatchGroup()
        
        group.enter()
        firestoreService.push(uid: user.uid, name: name, phone: phone, onError: onError) {
            group.leave()
        }
        
        if let dataImage = dataImage {
            group.enter()
            storageService.upload(dataImage, onSuccess: {
                group.leave()
            }, onError: onError)
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.saveUserData(user: user, name: name, phone: phone, imageData: dataImage)
            onSuccess?()
        }
    }
    
    private func saveUserData(user: User, name: String, phone: String, imageData: Data?) {
        if let profile = RealmService.shared.get(Profile.self).first {
            RealmService.shared.edit {
                profile.name = name
                profile.phone = phone
                profile.email = user.email ?? ""
                profile.photo = imageData
            }
        } else {
            let profile = Profile()
            profile.name = name
            profile.phone = phone
            profile.email = user.email ?? ""
            profile.photo = imageData
            RealmService.shared.save(profile)
        }
    }
}

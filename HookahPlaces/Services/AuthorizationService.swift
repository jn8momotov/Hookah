//
//  AuthorizationService.swift
//  HookahPlaces
//
//  Created by Евгений on 21/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias ErrorHandler = (String) -> Void
typealias SuccessHandler = () -> Void
typealias AuthHandler = (result: AuthDataResult?, error: Error?, onError: ErrorHandler?, onSuccess: SuccessHandler?)

protocol AuthorizationService {
    func signIn(email: String, password: String, onError: ErrorHandler?, onSuccess: SuccessHandler?)
    func signUp(email: String, password: String, onError: ErrorHandler?, onSuccess: SuccessHandler?)
    func signOut(onError: ErrorHandler?, onSuccess: SuccessHandler?)
}

final class AuthorizationServiceImpl: AuthorizationService {
    func signIn(email: String, password: String, onError: ErrorHandler?, onSuccess: SuccessHandler?) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            let handler = (result: result, error: error, onError: onError, onSuccess: onSuccess)
            self?.completion(handler)
        }
    }
    
    func signUp(email: String, password: String, onError: ErrorHandler?, onSuccess: SuccessHandler?) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            let handler = (result: result, error: error, onError: onError, onSuccess: onSuccess)
            self?.completion(handler)
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
}

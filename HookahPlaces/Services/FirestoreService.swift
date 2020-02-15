//
//  FirestoreService.swift
//  HookahPlaces
//
//  Created by Евгений on 23/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import Firebase

protocol FirestoreService {
    func push(uid: String, name: String, phone: String, onError: ErrorHandler?, onSuccess: VoidHandler?)
    func pull(uid: String, onError: ErrorHandler?, onSuccess: ((_ name: String, _ phone: String) -> Void)?)
}

final class FirestoreServiceImpl: FirestoreService {
    func push(uid: String, name: String, phone: String, onError: ErrorHandler?, onSuccess: VoidHandler?) {
        let data = [
            "name": name,
            "phone": phone
        ]
        Firestore.firestore().collection("users").document(uid).setData(data) { error in
            if let error = error {
                onError?(error.localizedDescription)
                return
            }
            onSuccess?()
        }
    }
    
    func pull(uid: String, onError: ErrorHandler?, onSuccess: ((_ name: String, _ phone: String) -> Void)?) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                onError?(error.localizedDescription)
                return
            }
            guard let data = snapshot?.data() else {
                onError?("Не удалось загрузить данные!")
                return
            }
            let phone = data["phone"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            onSuccess?(name, phone)
        }
    }
}

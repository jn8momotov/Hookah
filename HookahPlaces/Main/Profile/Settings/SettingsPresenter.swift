//
//  SettingsPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SettingsPresenterProtocol {
    func logOut()
}

final class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewController?
    
    init(view: SettingsViewController) {
        self.view = view
    }
    
    func logOut() {
        AuthorizationServiceImpl().signOut(onError: { [weak self] error in
            self?.view?.showAlert(title: "Ошибка!", description: error, completion: nil)
        }, onSuccess: { [weak self] in
            RealmService.shared.deleteAll(Profile.self)
            NotificationCenter.default.post(name: .logOut, object: nil)
            self?.view?.navigationController?.popViewController(animated: true)
        })
    }
}

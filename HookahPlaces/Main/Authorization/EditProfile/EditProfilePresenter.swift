//
//  EditProfilePresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 09/03/2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

protocol EditProfilePresenter {
    func save(image: UIImage?, name: String?)
}

final class EditProfilePresenterImpl: EditProfilePresenter {
    private weak var view: EditProfileViewController?
    private let authService: AuthorizationService = AuthorizationServiceImpl()
    private let storageService: StorageService = StorageServiceImpl()
    
    init(view: EditProfileViewController) {
        self.view = view
    }
    
    func save(image: UIImage?, name: String?) {
        guard let userName = name, !userName.isEmpty else {
            view?.showAlert(title: "Ошибка!", description: "Необходимо заполнить Ваше имя")
            return
        }
        
        let group = DispatchGroup()
        
        group.enter()
        uploadDisplayName(userName) {
            group.leave()
        }
        
        if let dataImage = image?.jpegData(compressionQuality: 1) {
            group.enter()
            uploadImage(dataImage) {
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            NotificationCenter.default.post(name: .signIn, object: nil)
            self?.view?.dismiss(animated: true, completion: nil)
        }
    }
}

extension EditProfilePresenterImpl {
    private func uploadDisplayName(_ name: String, completion: VoidHandler?) {
        authService.changeDisplayName(name, onSuccess: {
            completion?()
        }, onError: { [weak self] error in
            self?.view?.showAlert(title: "Ошибка!", description: error)
            completion?()
        })
    }
    
    private func uploadImage(_ dataImage: Data, completion: VoidHandler?) {
        storageService.upload(dataImage, onSuccess: {
            completion?()
        }, onError: { [weak self] error in
            self?.view?.showAlert(title: "Ошибка!", description: error)
            completion?()
        })
    }
}

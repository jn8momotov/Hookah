//
//  SignupCoordinator.swift
//  HookahPlaces
//
//  Created by Евгений on 21/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

protocol SignupCoordinator {
    func dismiss()
    func showError(_ error: String)
    func showCameraAlert(onDelete: VoidHandler?)
}

final class SignupCoordinatorImpl: SignupCoordinator {
    weak var view: SignupViewController?
    
    init(view: SignupViewController) {
        self.view = view
    }
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func showError(_ error: String) {
        view?.showAlert(title: "Ошибка", description: error)
    }
    
    func showCameraAlert(onDelete: VoidHandler?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = .black
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { [weak self] _ in
            self?.showImageController(sourceType: .camera)
        }
        let libraryAction = UIAlertAction(title: "Выбрать фото", style: .default) { [weak self] _ in
            self?.showImageController(sourceType: .photoLibrary)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        
        if let onDelete = onDelete {
            let removeAction = UIAlertAction(title: "Удалить фото", style: .destructive) { _ in
                onDelete()
            }
            alert.addAction(removeAction)
        }
        
        view?.presentFull(alert)
    }
}

extension SignupCoordinatorImpl {
    private func showImageController(sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.delegate = view
        view?.presentFull(controller)
    }
}

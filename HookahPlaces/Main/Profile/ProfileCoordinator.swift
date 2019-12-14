//
//  ProfileCoordinator.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 09.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

protocol ProfileCoordinatorProtocol {
    func openSignIn()
    func openSignUp()
    func openAbout()
    func openFeedback()
    func openAddingNewPlace()
}

final class ProfileCoordinator: ProfileCoordinatorProtocol {
    weak var view: ProfileViewController?
    
    init(view: ProfileViewController) {
        self.view = view
    }
    
    func openSignIn() {
        view?.presentRoot(SigninViewController())
    }
    
    func openSignUp() {
        view?.presentRoot(SignupViewController())
    }
    
    func openAbout() {
        view?.navigationController?.pushViewController(AboutViewController(), animated: true)
    }
    
    func openFeedback() {
        if FeedbackViewController.canSendMail() {
            view?.presentFull(FeedbackViewController())
        } else {
            view?.showAlert(title: "Ошибка",
                            description: "Для обратной связи войдите в аккаунт приложения почта на вашем устройстве или отправьте сообщение самостоятельно по адресу: hookah.places.app@gmail.com")
        }
    }
    
    func openAddingNewPlace() {
        view?.push(AddingPlaceViewController())
    }
}

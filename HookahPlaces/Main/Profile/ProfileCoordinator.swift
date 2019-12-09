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
        // TODO: + Else
        if FeedbackViewController.canSendMail() {
            view?.presentFull(FeedbackViewController())
        }
    }
    
    func openAddingNewPlace() {
        
    }
}

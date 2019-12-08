//
//  SignupPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 08/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SignupPresenterProtocol {
    
}

final class SignupPresenter: SignupPresenterProtocol {
    weak var view: SignupViewController?
    
    init(view: SignupViewController) {
        self.view = view
    }
}

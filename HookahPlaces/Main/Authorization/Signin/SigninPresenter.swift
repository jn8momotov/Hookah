//
//  SigninPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 08/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SigninPresenterProtocol {
    
}

final class SigninPresenter: SigninPresenterProtocol {
    weak var view: SigninViewController?
    
    init(view: SigninViewController) {
        self.view = view
    }
}

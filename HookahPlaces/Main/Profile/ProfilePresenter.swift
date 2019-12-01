//
//  ProfilePresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol {
    
}

final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewController?
    
    init(view: ProfileViewController) {
        self.view = view
    }
}

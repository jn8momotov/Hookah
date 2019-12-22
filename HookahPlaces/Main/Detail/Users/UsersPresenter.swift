//
//  UsersPresenter.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 09.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol UsersPresenterProtocol {
    var users: [Profile] { get }
}

final class UsersPresenter: UsersPresenterProtocol {
    weak var view: UsersViewController?
    
    var users: [Profile] = []
    
    init(view: UsersViewController) {
        self.view = view
        let user = Profile()
        user.name = "Evgeniy Momotov"
        users.append(user)
    }
}

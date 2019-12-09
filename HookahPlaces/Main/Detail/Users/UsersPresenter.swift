//
//  UsersPresenter.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 09.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol UsersPresenterProtocol {
    var users: [User] { get }
}

final class UsersPresenter: UsersPresenterProtocol {
    weak var view: UsersViewController?
    
    var users: [User] = []
    
    init(view: UsersViewController) {
        self.view = view
        let user = User()
        user.name = "Evgeniy Momotov"
        users.append(user)
    }
}

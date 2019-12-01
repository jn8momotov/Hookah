//
//  SettingsPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SettingsPresenterProtocol {
    
}

final class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewController?
    
    init(view: SettingsViewController) {
        self.view = view
    }
}

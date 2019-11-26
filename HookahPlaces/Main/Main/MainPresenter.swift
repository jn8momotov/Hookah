//
//  MainPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol MainPresenterProtocol {
    var places: [Place] { get }
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewController?
    
    var places: [Place] = []
    
    init(view: MainViewController) {
        self.view = view
        places = RealmService.shared.get(Place.self)
    }
}

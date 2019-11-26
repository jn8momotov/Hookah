//
//  MapPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 26/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol MapPresenterProtocol {
    var places: [Place] { get }
}

final class MapPresenter: MapPresenterProtocol {
    weak var view: MapViewController?
    
    var places: [Place] = []
    
    init(view: MapViewController) {
        self.view = view
        places = RealmService.shared.get(Place.self)
    }
}

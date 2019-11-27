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
    var accessToUserLocation: Bool { get }
}

final class MapPresenter: MapPresenterProtocol {
    weak var view: MapViewController?
    
    private let locationService: LocationServiceProtocol = LocationService()
    
    var places: [Place] = []
    
    var accessToUserLocation: Bool {
        return locationService.accessToUserLocation
    }
    
    init(view: MapViewController) {
        self.view = view
        places = RealmService.shared.get(Place.self)
        locationService.startUpdateLocation()
    }
}

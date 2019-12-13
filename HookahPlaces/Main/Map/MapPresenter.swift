//
//  MapPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 26/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import CoreLocation

protocol MapPresenterProtocol {
    var places: [Place] { get }
    var selectedPlace: Place? { get set }
    var accessToUserLocation: Bool { get }
    func openDetail()
    func openRoute()
    func openCall()
}

final class MapPresenter: MapPresenterProtocol {
    weak var view: MapViewController?
    
    private let coordinator: MapCoordinator
    private let locationService: LocationServiceProtocol = LocationService()
    
    var places: [Place] = []
    var selectedPlace: Place?
    
    var accessToUserLocation: Bool {
        return locationService.accessToUserLocation
    }
    
    init(view: MapViewController) {
        self.view = view
        self.coordinator = MapCoordinatorImpl(view: view)
        places = RealmService.shared.get(Place.self)
        locationService.startUpdateLocation()
    }
    
    func openRoute() {
        guard let placeLocation = selectedPlace?.location else {
            return
        }
        let from = locationService.userCoordinate
        let to = CLLocationCoordinate2D(latitude: placeLocation.latitude, longitude: placeLocation.longitude)
        coordinator.openRouteActionSheet(from: from, to: to)
    }
    
    func openDetail() {
        guard let selectedPlace = selectedPlace else {
            return
        }
        coordinator.openDetail(selectedPlace)
    }
    
    func openCall() {
        guard let phone = selectedPlace?.phone else {
            return
        }
        coordinator.openCall(to: phone)
    }
}

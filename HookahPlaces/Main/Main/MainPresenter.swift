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
    var typeSorted: TypeSortPlaces { get set }
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewController?
    
    private var locationService: LocationServiceProtocol = LocationService()
    
    var places: [Place] = []
    var typeSorted: TypeSortPlaces = .distance {
        didSet {
            updateSortedPlaces()
        }
    }
    
    init(view: MainViewController) {
        self.view = view
        places = RealmService.shared.get(Place.self)
        locationService.didUpdateLocation = { [weak self] in
            self?.updateDistanceToPlaces()
        }
        locationService.startUpdateLocation()
    }
}

extension MainPresenter {
    private func updateDistanceToPlaces() {
        for place in places {
            RealmService.shared.edit { [weak self] in
                place.location?.distanceTo = self?.locationService.distance(to: place) ?? 0.0
            }
        }
        updateSortedPlaces()
    }
    
    private func updateSortedPlaces() {
        typeSorted == .distance
            ? places.sort(by: { ($0.location?.distanceTo ?? 0.0) < ($1.location?.distanceTo ?? 0.0) })
            : places.sort(by: { ($0.rating?.total ?? 0.0) > ($1.rating?.total ?? 0.0) })
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadTableView()
        }
    }
}

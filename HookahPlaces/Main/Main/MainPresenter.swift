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
    private let placesService: PlacesService = PlacesServiceImpl()
    
    var places: [Place] = RealmService.shared.get(Place.self)
    var typeSorted: TypeSortPlaces = .distance {
        didSet {
            updateSortedPlaces()
        }
    }
    
    init(view: MainViewController) {
        self.view = view
        locationService.didUpdateLocation = { [weak self] in
            self?.updateDistanceToPlaces()
        }
        loadPlaces()
    }
}

extension MainPresenter {
    private func loadPlaces() {
        placesService.loadAll { [weak self] in
            DispatchQueue.main.async {
                self?.locationService.startUpdateLocation()
                self?.places = RealmService.shared.get(Place.self)
                self?.view?.reloadTableView()
            }
        }
    }
    
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

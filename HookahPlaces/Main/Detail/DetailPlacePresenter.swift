//
//  DetailPlacePresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 28/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

protocol DetailPlacePresenterProtocol {
    var viewModels: [DetailPlaceCellViewModelProtocol] { get }
}

final class DetailPlacePresenter: DetailPlacePresenterProtocol {
    weak var view: DetailPlaceViewController?
    private let coordinator: DetailPlaceCoordinatorProtocol
    
    var place: Place
    var viewModels: [DetailPlaceCellViewModelProtocol] = []
    
    init(view: DetailPlaceViewController, place: Place) {
        self.view = view
        self.place = place
        self.view?.title = place.name
        self.coordinator = DetailPlaceCoordinator(view: view)
        configureViewModel()
    }
    
    private var didTapCall: VoidHandler? {
        return { [weak self] in
            self?.coordinator.openCall(to: self?.place.phone ?? "")
        }
    }
    
    private var didTapNumberUsers: VoidHandler? {
        return { [weak self] in
            self?.coordinator.openUsersInPlace()
        }
    }
    
    private var didTapAddNewRating: VoidHandler? {
        return { [weak self] in
            guard AuthorizationServiceImpl.currentUser != nil else {
                self?.coordinator.openUnauthAlert()
                return
            }
            if let id = self?.place.id {
                self?.coordinator.openNewRating(for: id)
            }
        }
    }
    
    private var didTapMap: VoidHandler? {
        return { [weak self] in
            guard let place = self?.place else {
                return
            }
            self?.coordinator.openMap(place: place)
        }
    }
}

extension DetailPlacePresenter {
    private func configureViewModel() {
        addMainInfo()
        addRating()
        addAdditionals()
        addMap()
    }
    
    private func addMainInfo() {
        // TODO: Set reality number users
        viewModels.append(DetailPlaceHeaderViewModel(numberUsers: 1,
                                                     place: place,
                                                     didTapCall: didTapCall,
                                                     didTapNumberUsers: didTapNumberUsers))
    }
    
    private func addRating() {
        // TODO: Set reality number ratings
        let ratingModel = RatingPlace(total: place.total, hookah: place.hookah, staff: place.staff, place: place.place)
        viewModels.append(DetailPlaceRatingViewModel(ratingModel: ratingModel,
                                                     numberRatings: 5,
                                                     didTapNewRating: didTapAddNewRating))
    }
    
    private func addAdditionals() {
        viewModels.append(DetailPlaceAdditionalViewModel(.bankCard, value: place.bankCard))
        viewModels.append(DetailPlaceAdditionalViewModel(.tableGames, value: place.tableGames))
        viewModels.append(DetailPlaceAdditionalViewModel(.food, value: place.theirFood))
        viewModels.append(DetailPlaceAdditionalViewModel(.drink, value: place.theirDrink))
        viewModels.append(DetailPlaceAdditionalViewModel(.drinkAlko, value: place.theirAlko))
        viewModels.append(DetailPlaceAdditionalViewModel(.consoleGames, value: place.gameConsole))
        viewModels.append(DetailPlaceAdditionalViewModel(.wifi, value: place.wifi))
        viewModels.append(DetailPlaceAdditionalViewModel(.restarting, value: place.restarting))
    }
    
    private func addMap() {
        viewModels.append(DetailPlaceMapViewModel(latitude: place.latitude,
                                                  longitude: place.longitude,
                                                  name: place.name,
                                                  didTapMap: didTapMap))
    }
}

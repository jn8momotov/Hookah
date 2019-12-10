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
    func openYandexNavigator()
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
    
    private var didTapCall: DidTapHandler? {
        return { [weak self] in
            self?.coordinator.openCall(to: self?.place.phone ?? "")
        }
    }
    
    private var didTapNumberUsers: DidTapHandler? {
        return { [weak self] in
            self?.coordinator.openUsersInPlace()
        }
    }
    
    private var didTapAddNewRating: DidTapHandler? {
        return { [weak self] in
            self?.coordinator.openNewRating()
        }
    }
    
    private var didTapMap: DidTapHandler? {
        return { [weak self] in
            //self?.coordinator.openMap()
            self?.openYandexNavigator()
        }
    }
    
    func openYandexNavigator() {
        guard let location = place.location else {
            return
        }
        //let urlString = "yandexnavi://build_route_on_map?lat_to=\(location.latitude)&lon_to=\(location.longitude)"
        let urlString = "yandexmaps://maps.yandex.ru/?rtext=59.967870,30.242658~59.898495,30.299559&rtt=mt"
        guard let url = URL(string: urlString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let urlAppStoreString = "https://itunes.apple.com/ru/app/yandeks.navigator/id474500851?mt=8"
            guard let urlAppStore = URL(string: urlAppStoreString) else {
                return
            }
            UIApplication.shared.open(urlAppStore, options: [:], completionHandler: nil)
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
        viewModels.append(DetailPlaceRatingViewModel(ratingModel: place.rating ?? RatingPlace(),
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
        viewModels.append(DetailPlaceMapViewModel(latitude: place.location?.latitude ?? 0.0,
                                                  longitude: place.location?.longitude ?? 0.0,
                                                  name: place.name,
                                                  didTapMap: didTapMap))
    }
}

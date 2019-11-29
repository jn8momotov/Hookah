//
//  DetailPlacePresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 28/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol DetailPlacePresenterProtocol {
    var viewModels: [DetailPlaceCellViewModelProtocol] { get }
}

final class DetailPlacePresenter: DetailPlacePresenterProtocol {
    weak var view: DetailPlaceViewController?
    var place: Place
    var viewModels: [DetailPlaceCellViewModelProtocol] = []
    
    init(view: DetailPlaceViewController, place: Place) {
        self.view = view
        self.place = place
        configureViewModel()
    }
}

extension DetailPlacePresenter {
    private func configureViewModel() {
        viewModels.append(DetailPlaceHeaderViewModel(numberUsers: 1, place: place))
        viewModels.append(DetailPlaceRatingViewModel(ratingModel: place.rating ?? RatingPlace(), numberRatings: 5))
        viewModels.append(DetailPlaceAdditionalViewModel(.bankCard, value: place.bankCard))
        viewModels.append(DetailPlaceAdditionalViewModel(.tableGames, value: place.tableGames))
        viewModels.append(DetailPlaceAdditionalViewModel(.food, value: place.theirFood))
        viewModels.append(DetailPlaceAdditionalViewModel(.drink, value: place.theirDrink))
        viewModels.append(DetailPlaceAdditionalViewModel(.drinkAlko, value: place.theirAlko))
        viewModels.append(DetailPlaceAdditionalViewModel(.consoleGames, value: place.gameConsole))
        viewModels.append(DetailPlaceAdditionalViewModel(.wifi, value: place.wifi))
        viewModels.append(DetailPlaceAdditionalViewModel(.restarting, value: place.restarting))
    }
}

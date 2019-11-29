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
    }
}

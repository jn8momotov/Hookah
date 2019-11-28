//
//  DetailPlacePresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 28/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol DetailPlacePresenterProtocol {
    
}

final class DetailPlacePresenter: DetailPlacePresenterProtocol {
    weak var view: DetailPlaceViewController?
    var place: Place
    
    init(view: DetailPlaceViewController, place: Place) {
        self.view = view
        self.place = place
    }
}

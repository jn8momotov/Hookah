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
    
    init(view: DetailPlaceViewController) {
        self.view = view
    }
}

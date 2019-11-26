//
//  MapPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 26/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol MapPresenterProtocol {
    
}

final class MapPresenter: MapPresenterProtocol {
    weak var view: MapViewController?
    
    init(view: MapViewController) {
        self.view = view
    }
}

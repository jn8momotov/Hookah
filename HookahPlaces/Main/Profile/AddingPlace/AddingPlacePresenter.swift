//
//  AddingPlacePresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 15/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol AddingPlacePresenter {
    
}

final class AddingPlacePresenterImpl: AddingPlacePresenter {
    weak var view: AddingPlaceViewController?
    
    init(view: AddingPlaceViewController) {
        self.view = view
    }
}

//
//  NewRatingPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol NewRatingPresenterProtocol {
    var hookahRating: Int { get set }
    var staffRating: Int { get set }
    var placeRating: Int { get set }
}

final class NewRatingPresenter: NewRatingPresenterProtocol {
    weak var view: NewRatingViewController?
    
    var hookahRating: Int = 0
    var staffRating: Int = 0
    var placeRating: Int = 0
    
    init(view: NewRatingViewController) {
        self.view = view
    }
}

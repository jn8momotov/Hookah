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
    func sendRating(onSuccess: VoidHandler?, onError: ErrorHandler?)
}

final class NewRatingPresenter: NewRatingPresenterProtocol {
    weak var view: NewRatingViewController?
    private let service: PlacesService = PlacesServiceImpl()
    
    var hookahRating: Int = 0
    var staffRating: Int = 0
    var placeRating: Int = 0
    
    private let placeId: Int
    
    init(view: NewRatingViewController, placeId: Int) {
        self.view = view
        self.placeId = placeId
    }
    
    func sendRating(onSuccess: VoidHandler?, onError: ErrorHandler?) {
        guard let uid = AuthorizationServiceImpl.currentUser?.uid else {
            onError?("Не удалось получить Ваши пользовательские данные!")
            return
        }
        let model = RatingPlace(total: 0,
                                hookah: Float(hookahRating),
                                staff: Float(staffRating),
                                place: Float(placeRating))
        service.sendRating(model, for: placeId, from: uid, onSuccess: onSuccess, onError: onError)
    }
}

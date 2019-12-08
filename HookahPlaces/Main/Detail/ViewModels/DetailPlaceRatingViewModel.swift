//
//  DetailPlaceRatingViewModel.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 29.11.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

typealias RatingViewModel = (title: String, rating: Float)

final class DetailPlaceRatingViewModel: DetailPlaceCellViewModelProtocol {
    let identifier = String(describing: DetailPlaceRatingCell.self)
    
    var rating: Float
    var hookah: RatingViewModel
    var staff: RatingViewModel
    var place: RatingViewModel
    var numberRatings: Int
    let didTapNewRating: DidTapHandler?
    
    init(ratingModel: RatingPlace, numberRatings: Int, didTapNewRating: DidTapHandler?) {
        self.rating = ratingModel.total
        self.hookah = ("Кальян", ratingModel.hookah)
        self.staff = ("Персонал", ratingModel.staff)
        self.place = ("Заведение", ratingModel.place)
        self.numberRatings = numberRatings
        self.didTapNewRating = didTapNewRating
    }
}

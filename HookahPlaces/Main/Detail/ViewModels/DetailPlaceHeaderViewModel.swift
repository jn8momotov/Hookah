//
//  DetailPlaceHeaderViewModel.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 29.11.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

typealias DidTapHandler = () -> Void

final class DetailPlaceHeaderViewModel: DetailPlaceCellViewModelProtocol {
    let identifier = DetailPlaceHeaderCell.identifier
    
    var numberUsers: Int
    let place: Place
    let didTapCall: DidTapHandler?
    let didTapNumberUsers: DidTapHandler?
    
    init(numberUsers: Int, place: Place, didTapCall: DidTapHandler?, didTapNumberUsers: DidTapHandler?) {
        self.numberUsers = numberUsers
        self.place = place
        self.didTapCall = didTapCall
        self.didTapNumberUsers = didTapNumberUsers
    }
}

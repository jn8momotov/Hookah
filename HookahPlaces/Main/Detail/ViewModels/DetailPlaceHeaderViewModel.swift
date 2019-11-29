//
//  DetailPlaceHeaderViewModel.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 29.11.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

final class DetailPlaceHeaderViewModel: DetailPlaceCellViewModelProtocol {
    let identifier = DetailPlaceHeaderCell.identifier
    
    var numberUsers: Int
    var place: Place
    
    init(numberUsers: Int, place: Place) {
        self.numberUsers = numberUsers
        self.place = place
    }
}

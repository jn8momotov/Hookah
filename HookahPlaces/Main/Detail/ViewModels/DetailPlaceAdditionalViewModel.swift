//
//  DetailPlaceAdditionalViewModel.swift
//  HookahPlaces
//
//  Created by Евгений on 29/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

final class DetailPlaceAdditionalViewModel: DetailPlaceCellViewModelProtocol {
    let identifier = DetailPlaceAdditionalDataCell.identifier
    
    let additional: PlaceAdditional
    let value: Bool
    
    init(_ additional: PlaceAdditional, value: Bool) {
        self.additional = additional
        self.value = value
    }
}

//
//  DetailPlaceMapViewModel.swift
//  HookahPlaces
//
//  Created by Евгений on 29/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

final class DetailPlaceMapViewModel: DetailPlaceCellViewModelProtocol {
    let identifier = DetailPlaceMapCell.identifier
    
    let latitude: Double
    let longitude: Double
    let name: String
    
    init(latitude: Double, longitude: Double, name: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
}

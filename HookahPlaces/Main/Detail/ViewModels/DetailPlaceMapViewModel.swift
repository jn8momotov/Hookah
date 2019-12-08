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
    let didTapMap: DidTapHandler?
    
    init(latitude: Double, longitude: Double, name: String, didTapMap: DidTapHandler?) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.didTapMap = didTapMap
    }
}

//
//  PlacePointAnnotation.swift
//  HookahPlaces
//
//  Created by Евгений on 26/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import MapKit

final class PlacePointAnnotation: MKPointAnnotation {
    let identifier: Int
    
    init(identifier: Int) {
        self.identifier = identifier
        super.init()
    }
}

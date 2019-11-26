//
//  LocationService.swift
//  HookahPlaces
//
//  Created by Евгений on 26/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol LocationServiceProtocol {
    
}

final class LocationService: LocationServiceProtocol {
    static let shared: LocationServiceProtocol = LocationService()
    private init() {}
}

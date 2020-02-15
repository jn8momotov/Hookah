//
//  LocationPlace.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import RealmSwift

final class LocationPlace: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var metro = ""
    @objc dynamic var address = ""
    @objc dynamic var distanceTo: Float = 0.0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension LocationPlace: Codable {
    
}

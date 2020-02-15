//
//  RatingPlace.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 29.11.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import RealmSwift

final class RatingPlace: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var total: Float = 0.0
    @objc dynamic var hookah: Float = 0.0
    @objc dynamic var place: Float = 0.0
    @objc dynamic var staff: Float = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension RatingPlace: Codable {
    
}

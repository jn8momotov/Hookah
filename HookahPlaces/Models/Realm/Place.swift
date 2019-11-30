//
//  Place.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import RealmSwift

final class Place: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var image: Data?
    @objc dynamic var name = ""
    @objc dynamic var phone = ""
    
    @objc dynamic var metro = ""
    @objc dynamic var address = ""
    @objc dynamic var distanceTo: Float = 0.0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    @objc dynamic var bankCard = false
    @objc dynamic var gameConsole = false
    @objc dynamic var restarting = false
    @objc dynamic var tableGames = false
    @objc dynamic var theirAlko = false
    @objc dynamic var theirFood = false
    @objc dynamic var theirDrink = false
    @objc dynamic var wifi = false
    
    @objc dynamic var rating: RatingPlace?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

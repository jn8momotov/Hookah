//
//  Place.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseDatabase

final class Place: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var image: Data?
    @objc dynamic var name = ""
    @objc dynamic var phone = ""
    
    @objc dynamic var bankCard = false
    @objc dynamic var gameConsole = false
    @objc dynamic var restarting = false
    @objc dynamic var tableGames = false
    @objc dynamic var theirAlko = false
    @objc dynamic var theirFood = false
    @objc dynamic var theirDrink = false
    @objc dynamic var wifi = false
    
    @objc dynamic var location: LocationPlace?
    @objc dynamic var rating: RatingPlace?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Place {
    func set(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: AnyObject] else {
            return
        }
        
        id = snapshotValue["id"] as? Int ?? 0
        name = snapshotValue["name"] as? String ?? ""
        phone = snapshotValue["phone"] as? String ?? ""
        
        let total = snapshotValue["rating"] as? Float ?? 0.0
        let hookah = snapshotValue["ratingHookah"] as? Float ?? 0.0
        let place = snapshotValue["ratingPlace"] as? Float ?? 0.0
        let staff = snapshotValue["ratingStaff"] as? Float ?? 0.0
        
        let ratingPlace = RatingPlace()
        ratingPlace.total = Float(round(10 * total) / 10)
        ratingPlace.hookah = Float(round(10 * hookah) / 10)
        ratingPlace.place = Float(round(10 * place) / 10)
        ratingPlace.staff = Float(round(10 * staff) / 10)
        rating = ratingPlace
        
        let locationPlace = LocationPlace()
        locationPlace.address = snapshotValue["address"] as? String ?? ""
        locationPlace.latitude = snapshotValue["latitude"] as? Double ?? 0.0
        locationPlace.longitude = snapshotValue["longitude"] as? Double ?? 0.0
        locationPlace.metro = snapshotValue["metroStation"] as? String ?? ""
        locationPlace.distanceTo = 0.0
        location = locationPlace
        
        bankCard = snapshotValue["bankCard"] as? Bool ?? false
        gameConsole = snapshotValue["gameConsole"] as? Bool ?? false
        restarting = snapshotValue["restarting"] as? Bool ?? false
        tableGames = snapshotValue["tableGames"] as? Bool ?? false
        theirAlko = snapshotValue["theirAlko"] as? Bool ?? false
        theirFood = snapshotValue["theirFoot"] as? Bool ?? false
        theirDrink = snapshotValue["theirDrink"] as? Bool ?? false
        wifi = snapshotValue["wifi"] as? Bool ?? false
    }
}

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
    
    @objc dynamic var total: Float = 0.0
    @objc dynamic var hookah: Float = 0.0
    @objc dynamic var place: Float = 0.0
    @objc dynamic var staff: Float = 0.0
    
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
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Place {
    func set(dictionary: [String: Any]) {
        id = dictionary["id"] as? Int ?? -1
        name = dictionary["name"] as? String ?? ""
        phone = dictionary["phone"] as? String ?? ""
        image = RealmService.shared.get(Place.self, predicate: NSPredicate(format: "id == \(id)")).first?.image
        
        address = dictionary["address"] as? String ?? ""
        latitude = dictionary["latitude"] as? Double ?? 0.0
        longitude = dictionary["longitude"] as? Double ?? 0.0
        metro = dictionary["metroStation"] as? String ?? ""
        
        setRating(dictionary: dictionary)
        
        bankCard = dictionary["bankCard"] as? Bool ?? false
        gameConsole = dictionary["gameConsole"] as? Bool ?? false
        restarting = dictionary["restarting"] as? Bool ?? false
        tableGames = dictionary["tableGames"] as? Bool ?? false
        theirAlko = dictionary["theirAlko"] as? Bool ?? false
        theirFood = dictionary["theirFoot"] as? Bool ?? false
        theirDrink = dictionary["theirDrink"] as? Bool ?? false
        wifi = dictionary["wifi"] as? Bool ?? false
    }
    
    func setRating(dictionary: [String: Any]) {
        let total = dictionary["rating"] as? Double ?? 0.0
        let hookah = dictionary["ratingHookah"] as? Double ?? 0.0
        let place = dictionary["ratingPlace"] as? Double ?? 0.0
        let staff = dictionary["ratingStaff"] as? Double ?? 0.0
        
        print("TOTAL \(metro): \(dictionary["rating"])")
        
        self.total = Float(round(10 * total) / 10)
        self.hookah = Float(round(10 * hookah) / 10)
        self.place = Float(round(10 * place) / 10)
        self.staff = Float(round(10 * staff) / 10)
    }
}

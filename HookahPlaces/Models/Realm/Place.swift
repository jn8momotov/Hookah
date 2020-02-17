//
//  Place.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation
import Contentful

final class Place: Object {
    @objc dynamic var id = UUID().uuidString
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
    
    @objc dynamic var updatedAt: Date?
    @objc dynamic var createdAt: Date?
    
    var localeCode: String?
    var locationCoord: CLLocationCoordinate2D?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    public required init(from decoder: Decoder) throws {
        let sys         = try decoder.sys()

        id              = sys.id
        localeCode      = sys.locale
        updatedAt       = sys.updatedAt
        createdAt       = sys.createdAt

        let fields      = try decoder.contentfulFieldsContainer(keyedBy: Place.FieldKeys.self)
        name = try (fields.decodeIfPresent(String.self, forKey: .name) ?? "")
        if let location = try (fields.decodeIfPresent(Location.self, forKey: .locationCoord)) {
            locationCoord = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        }
        
        //CLLocationCoordinate2D
//        self.color      = try fields.decodeIfPresent(String.self, forKey: .color)
//        self.likes      = try fields.decodeIfPresent(Array<String>.self, forKey: .likes)
//        self.lives      = try fields.decodeIfPresent(Int.self, forKey: .lives)
//
//        try fields.resolveLink(forKey: .bestFriend, decoder: decoder) { [weak self] linkedCat in
//          self?.bestFriend = linkedCat as? Cat
//        }
//        try fields.resolveLink(forKey: .image, decoder: decoder) { [weak self] image in
//          self?.image = image as? Asset
//        }
    }
    required init() {
        super.init()
    }
}

extension Place: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case updatedAt
        case createdAt
        case localeCode
        case locationCoord = "location"
    }
}

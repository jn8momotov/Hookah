//
//  User.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import RealmSwift

final class User: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var photo: Data?
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

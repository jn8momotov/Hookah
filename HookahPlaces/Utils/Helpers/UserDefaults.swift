//
//  UserDefaults.swift
//  HookahPlaces
//
//  Created by Евгений on 23/02/2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import Foundation

extension UserDefaults {
    var versionDB: String? {
        get { return string(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
}

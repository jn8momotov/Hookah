//
//  String.swift
//  HookahPlaces
//
//  Created by Евгений on 23/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
}

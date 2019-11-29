//
//  Font.swift
//  HookahPlaces
//
//  Created by Евгений on 29/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

enum WeightFont: String {
    case regular = "Regular"
    case medium = "Medium"
    case bold = "Bold"
}

extension UIFont {
    static func main(ofSize: CGFloat, weight: WeightFont? = nil) -> UIFont {
        let weight = (weight ?? .regular).rawValue
        return UIFont(name: "AppleSDGothicNeo-\(weight)", size: ofSize) ?? .systemFont(ofSize: ofSize)
    }
}

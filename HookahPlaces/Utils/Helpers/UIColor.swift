//
//  UIColor.swift
//  HookahPlaces
//
//  Created by Евгений on 30/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex string: String) {
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        
        guard hex.count == 3 || hex.count == 6 else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(red: CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
                  green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
                  blue: CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0,
                  alpha: 1.0)
    }
    
    func hex(hashPrefix: Bool = true) -> String {
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let prefix = hashPrefix ? "#" : ""
        return String(format: "\(prefix)%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
}

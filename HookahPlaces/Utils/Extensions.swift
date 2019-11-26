//
//  Extensions.swift
//  HookahPlaces
//
//  Created by Евгений on 28/08/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

extension UIFont {
    static func main(ofSize: CGFloat, weight: UIFont.Weight? = nil) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: weight ?? .regular)
    }
}

extension UIViewController {
    func presentFull(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: animated, completion: completion)
    }
}

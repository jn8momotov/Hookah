//
//  Extensions.swift
//  HookahPlaces
//
//  Created by Евгений on 28/08/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentFull(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: animated, completion: completion)
    }
}

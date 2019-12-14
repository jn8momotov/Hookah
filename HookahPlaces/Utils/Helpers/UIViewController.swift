//
//  UIViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 15/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentFull(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
    
    func presentRoot(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        let navigation = NavigationController(rootViewController: viewController)
        presentFull(navigation)
    }
    
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setBackBarButtonItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func addCancelBarButtonItem() {
        let closeBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "close"),
            style: .plain,
            target: self,
            action: #selector(didTapOnCloseBarButtonItem)
        )
        closeBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }
    
    @objc
    private func didTapOnCloseBarButtonItem() {
        dismiss(animated: true, completion: nil)
    }
}

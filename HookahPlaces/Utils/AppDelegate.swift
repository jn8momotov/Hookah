//
//  AppDelegate.swift
//  HookahPlaces
//
//  Created by Евгений on 26/08/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit
import Contentful

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        let test = ContentfullDataProvider()
        test.fetchAll(Place.self) { result in
            switch result {
            case .success(let places):
                print(places)
            case .failure(let error):
                print(error)
            }
        }
        
        return true
    }
}

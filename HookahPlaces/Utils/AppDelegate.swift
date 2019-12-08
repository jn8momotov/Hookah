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
        
        let client = Client(spaceId: "zoxp97809y35",
                            environmentId: "master", // Defaults to "master" if omitted.
                            accessToken: "MtfLg1dtaxzim4faQ_K5qZMW2krMXoJz7XijtTfW7Qc")
        
        

        client.fetch(Entry.self, id: "3IB4eylBXsqLx5oHfRTxpj") { (result: Result<Entry>) in
            switch result {
            case .success(let place):
                print(place)
            case .error(let error):
                print("Error \(error)!")
            }
        }
        
        return true
    }
}

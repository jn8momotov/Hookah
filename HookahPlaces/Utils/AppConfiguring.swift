//
//  AppConfiguring.swift
//  HookahPlaces
//
//  Created by Евгений on 23/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import Firebase
import IQKeyboardManagerSwift

protocol AppConfiguring {
    func configure()
}

final class AppConfiguringImpl: AppConfiguring {
    func configure() {
        setupFirebase()
        setupIQKeyboardManager()
    }
}

extension AppConfiguringImpl {
    private func setupFirebase() {
        FirebaseApp.configure()
    }
    
    private func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Готово"
        IQKeyboardManager.shared.toolbarBarTintColor = .white
        IQKeyboardManager.shared.toolbarTintColor = .black
    }
}

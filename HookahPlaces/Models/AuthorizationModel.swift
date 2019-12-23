//
//  AuthorizationModel.swift
//  HookahPlaces
//
//  Created by Евгений on 23/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

struct SignInModel {
    let email: String
    let password: String
}

struct SignUpModel {
    let isAccept: Bool
    let photo: Data?
    let name: String
    let phone: String
    let signInModel: SignInModel
}

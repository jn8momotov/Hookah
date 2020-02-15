//
//  ProfileAuthorizationViewModel.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

final class ProfileAuthorizationViewModel: ProfileViewModelProtocol {
    let identifier = ProfileAuthorizationCell.identifier
    
    let didTapSignIn: VoidHandler?
    let didTapSignUp: VoidHandler?
    let didTapCell: VoidHandler?
    
    init(didTapSignIn: VoidHandler?, didTapSignUp: VoidHandler?) {
        self.didTapSignIn = didTapSignIn
        self.didTapSignUp = didTapSignUp
        self.didTapCell = nil
    }
}

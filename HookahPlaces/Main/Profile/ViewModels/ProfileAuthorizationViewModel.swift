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
    let didTapCell: VoidHandler?
    
    init(didTapSignIn: VoidHandler?) {
        self.didTapSignIn = didTapSignIn
        self.didTapCell = nil
    }
}

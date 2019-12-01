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
    
    let didTapSignIn: DidTapHandler?
    let didTapSignUp: DidTapHandler?
    let didTapCell: DidTapHandler?
    
    init(didTapSignIn: DidTapHandler?, didTapSignUp: DidTapHandler?) {
        self.didTapSignIn = didTapSignIn
        self.didTapSignUp = didTapSignUp
        self.didTapCell = nil
    }
}

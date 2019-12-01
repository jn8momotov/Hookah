//
//  ProfileInfoUserViewModel.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

final class ProfileInfoUserViewModel: ProfileViewModelProtocol {
    let identifier = ProfileInfoUserCell.identifier
    
    let name: String
    let email: String
    let didTapCell: DidTapHandler?
    
    init(name: String, email: String, didTapCell: DidTapHandler? = nil) {
        self.name = name
        self.email = email
        self.didTapCell = didTapCell
    }
}

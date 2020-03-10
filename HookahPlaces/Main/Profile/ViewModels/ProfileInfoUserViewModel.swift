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
    let phoneNumber: String
    let didTapCell: VoidHandler?
    
    init(name: String?, phoneNumber: String?, didTapCell: VoidHandler? = nil) {
        self.name = name ?? ""
        self.phoneNumber = phoneNumber ?? ""
        self.didTapCell = didTapCell
    }
}

//
//  ProfileImageViewModel.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

final class ProfileImageViewModel: ProfileViewModelProtocol {
    let identifier = ProfileImageCell.identifier
    
    let dataImage: Data?
    let didTapCell: DidTapHandler?
    
    init(dataImage: Data?, didTapCell: DidTapHandler? = nil) {
        self.dataImage = dataImage
        self.didTapCell = didTapCell
    }
}

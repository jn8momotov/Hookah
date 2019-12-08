//
//  ProfileSettingViewModel.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

final class ProfileSettingViewModel: ProfileViewModelProtocol {
    let identifier = ProfileSettingCell.identifier
    
    let title: String
    let topLine: Bool
    let bottomLine: Bool
    let didTapCell: DidTapHandler?
    
    init(title: String, topLine: Bool = false, bottomLine: Bool = false, didTapCell: DidTapHandler?) {
        self.title = title
        self.didTapCell = didTapCell
        self.topLine = topLine
        self.bottomLine = bottomLine
    }
}

//
//  ProfilePresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol {
    var viewModels: [ProfileViewModelProtocol] { get }
}

final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewController?
    private var user: User?
    var viewModels: [ProfileViewModelProtocol] = []
    
    init(view: ProfileViewController) {
        self.view = view
        configureViewModel()
    }
}

extension ProfilePresenter {
    private func configureViewModel() {
        viewModels.append(ProfileImageViewModel(dataImage: user?.photo))
        viewModels.append(ProfileInfoUserViewModel(name: "Евгений Момотов", email: "jn8momotov@gmail.com"))
        
        viewModels.append(ProfileSettingViewModel(title: "Добавить заведение", topLine: true, bottomLine: true, didTapCell: nil))
        viewModels.append(ProfileSettingViewModel(title: "Написать разработчику", bottomLine: true, didTapCell: nil))
        viewModels.append(ProfileSettingViewModel(title: "О приложении", bottomLine: true, didTapCell: nil))
    }
}

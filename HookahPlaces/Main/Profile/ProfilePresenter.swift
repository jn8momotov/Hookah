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
    
    private var didTapSignIn: DidTapHandler {
        return { [weak self] in
            self?.view?.openSignIn()
        }
    }
    
    private var didTapSignUp: DidTapHandler {
        return { [weak self] in
            self?.view?.openSignUp()
        }
    }
}

extension ProfilePresenter {
    // TODO: Set view model if user (isLogin)
    // TODO: Set user info from realm
    private func configureViewModel() {
        viewModels.append(ProfileImageViewModel(dataImage: user?.photo))
//        viewModels.append(ProfileInfoUserViewModel(name: "Евгений Момотов", email: "jn8momotov@gmail.com"))
        viewModels.append(ProfileAuthorizationViewModel(didTapSignIn: didTapSignIn, didTapSignUp: didTapSignUp))
        
        viewModels.append(ProfileSettingViewModel(title: "Добавить заведение", topLine: true, bottomLine: true, didTapCell: nil))
        viewModels.append(ProfileSettingViewModel(title: "Написать разработчику", bottomLine: true, didTapCell: nil))
        viewModels.append(ProfileSettingViewModel(title: "О приложении", bottomLine: true, didTapCell: nil))
    }
}

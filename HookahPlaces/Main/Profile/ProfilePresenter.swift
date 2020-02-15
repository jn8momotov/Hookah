//
//  ProfilePresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol {
    var isSignIn: Bool { get }
    var viewModels: [ProfileViewModelProtocol] { get }
    var didTapSettings: DidTapHandler { get }
}

final class ProfilePresenter: ProfilePresenterProtocol {
    private weak var view: ProfileViewController?
    private let coordinator: ProfileCoordinator
    
    private var user: Profile?
    var viewModels: [ProfileViewModelProtocol] = []
    
    var isSignIn: Bool {
        return AuthorizationServiceImpl.currentUser != nil
    }
    
    init(view: ProfileViewController) {
        self.view = view
        coordinator = ProfileCoordinator(view: view)
        configureViewModel()
        addSignInObserver()
        addLogOutObserver()
    }
    
    var didTapSettings: DidTapHandler {
        return { [weak self] in
            self?.coordinator.openSettings()
        }
    }
    
    private var didTapSignIn: DidTapHandler {
        return { [weak self] in
            self?.coordinator.openSignIn()
        }
    }
    
    private var didTapSignUp: DidTapHandler {
        return { [weak self] in
            self?.coordinator.openSignUp()
        }
    }
    
    private var didTapAbout: DidTapHandler {
        return { [weak self] in
            self?.coordinator.openAbout()
        }
    }
    
    private var didTapFeedback: DidTapHandler {
        return { [weak self] in
            self?.coordinator.openFeedback()
        }
    }
    
    private var didTapAddNewPlace: DidTapHandler {
        return { [weak self] in
            self?.coordinator.openAddingNewPlace()
        }
    }
}

extension ProfilePresenter {
    private func configureViewModel() {
        user = getProfile()
        viewModels.removeAll()
        let dataImage = isSignIn ? user?.photo : nil
        viewModels.append(ProfileImageViewModel(dataImage: dataImage))
        if isSignIn {
            viewModels.append(ProfileInfoUserViewModel(name: user?.name, email: user?.email))
        } else {
            viewModels.append(ProfileAuthorizationViewModel(didTapSignIn: didTapSignIn, didTapSignUp: didTapSignUp))
        }
        viewModels.append(ProfileSettingViewModel(title: "Добавить заведение",
                                                  topLine: true,
                                                  bottomLine: true,
                                                  didTapCell: didTapAddNewPlace))
        viewModels.append(ProfileSettingViewModel(title: "Написать разработчику",
                                                  bottomLine: true,
                                                  didTapCell: didTapFeedback))
        viewModels.append(ProfileSettingViewModel(title: "О приложении",
                                                  bottomLine: true,
                                                  didTapCell: didTapAbout))
    }
    
    private func addSignInObserver() {
        NotificationCenter.default.addObserver(forName: .signIn, object: nil, queue: nil) { [weak self] _ in
            self?.user = self?.getProfile()
            self?.updateData()
        }
    }
    
    private func addLogOutObserver() {
        NotificationCenter.default.addObserver(forName: .logOut, object: nil, queue: nil) { [weak self] _ in
            self?.updateData()
        }
    }
    
    private func updateData() {
        configureViewModel()
        view?.reloadView()
    }
    
    private func getProfile() -> Profile? {
        return RealmService.shared.get(Profile.self).first
    }
}

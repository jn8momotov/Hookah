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
    var didTapSettings: VoidHandler { get }
}

final class ProfilePresenter: ProfilePresenterProtocol {
    private weak var view: ProfileViewController?
    private let coordinator: ProfileCoordinator
    
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
    
    var didTapSettings: VoidHandler {
        return { [weak self] in
            self?.coordinator.openSettings()
        }
    }
    
    private var didTapSignIn: VoidHandler {
        return { [weak self] in
            self?.coordinator.openSignIn()
        }
    }
    
    private var didTapAbout: VoidHandler {
        return { [weak self] in
            self?.coordinator.openAbout()
        }
    }
    
    private var didTapFeedback: VoidHandler {
        return { [weak self] in
            self?.coordinator.openFeedback()
        }
    }
    
    private var didTapAddNewPlace: VoidHandler {
        return { [weak self] in
            self?.coordinator.openAddingNewPlace()
        }
    }
}

extension ProfilePresenter {
    private func configureViewModel() {
        let user = AuthorizationServiceImpl.currentUser
        viewModels.removeAll()
        if isSignIn {
            viewModels.append(ProfileImageViewModel(dataImage: getProfile()?.photo))
            viewModels.append(ProfileInfoUserViewModel(name: user?.displayName, phoneNumber: user?.phoneNumber))
        } else {
            viewModels.append(ProfileImageViewModel(dataImage: nil))
            viewModels.append(ProfileAuthorizationViewModel(didTapSignIn: didTapSignIn))
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

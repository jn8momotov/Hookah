//
//  AboutPresenter.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 09.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol AboutPresenterProtocol {
    var viewModel: [AboutPresenter.ViewModel] { get }
}

final class AboutPresenter: AboutPresenterProtocol {
    weak var view: AboutViewController?
    var viewModel: [AboutPresenter.ViewModel] = []
    
    init(view: AboutViewController) {
        self.view = view
        configureViewModel()
    }
}

extension AboutPresenter {
    struct ViewModel {
        let title: String
        let didSelect: VoidHandler?
    }
    
    private func configureViewModel() {
        viewModel.append(ViewModel(title: "Пользовательское соглашение", didSelect: self.view?.pushToUserAgreement))
    }
}

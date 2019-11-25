//
//  SearchPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol {
    
}

final class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewController?
    
    init(view: SearchViewController) {
        self.view = view
    }
}

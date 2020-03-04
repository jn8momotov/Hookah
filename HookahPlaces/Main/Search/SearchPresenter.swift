//
//  SearchPresenter.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol {
    var places: [Place] { get }
    func searchPlace(_ prefix: String)
}

final class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewController?
    
    private let allPlaces: [Place]
    
    var places: [Place] = [] {
        didSet {
            view?.reloadTableView()
        }
    }
    
    init(view: SearchViewController) {
        self.view = view
        self.allPlaces = RealmService.shared.get(Place.self)
    }
    
    func searchPlace(_ prefix: String) {
        guard !prefix.isEmpty else {
            places = []
            return
        }
        places = allPlaces.filter({
            $0.name.hasPrefix(prefix)
            || ($0.metro).hasPrefix(prefix)
        })
    }
}

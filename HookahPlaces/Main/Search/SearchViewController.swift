//
//  SearchViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    private var presenter: SearchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter(view: self)
        configureView()
    }
}

extension SearchViewController {
    private func configureView() {
        title = "Search"
        view.backgroundColor = .groupTableViewBackground
    }
}

//
//  DetailPlaceViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 28/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class DetailPlaceViewController: UIViewController {
    var presenter: DetailPlacePresenterProtocol!
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

extension DetailPlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension DetailPlaceViewController {
    private func configureView() {
        view.backgroundColor = .white
        addTableView()
    }
    
    private func addTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        registerCells()
    }
    
    private func registerCells() {
        
    }
}

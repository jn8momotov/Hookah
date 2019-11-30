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
    
    func openMap() {
        presentFull(MapViewController(), animated: true, completion: nil)
    }
}

extension DetailPlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
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
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(DetailPlaceHeaderCell.self, forCellReuseIdentifier: DetailPlaceHeaderCell.identifier)
        tableView.register(DetailPlaceRatingCell.self, forCellReuseIdentifier: DetailPlaceRatingCell.identifier)
        tableView.register(DetailPlaceMapCell.self, forCellReuseIdentifier: DetailPlaceMapCell.identifier)
        tableView.register(DetailPlaceAdditionalDataCell.self,
                           forCellReuseIdentifier: DetailPlaceAdditionalDataCell.identifier)
    }
    
    private func cell(at indexPath: IndexPath) -> UITableViewCell {
        let viewModel = presenter.viewModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.identifier,
                                                       for: indexPath) as? DetailPlaceCellProtocol else {
            return UITableViewCell()
        }
        cell.set(viewModel)
        return cell
    }
}

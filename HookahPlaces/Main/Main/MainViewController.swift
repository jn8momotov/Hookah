//
//  MainViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 26/08/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private var presenter: MainPresenterProtocol!
    
    private let filterControl = UISegmentedControl()
    private let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self)
        configureView()
        savePlaces()
    }
    
    @objc
    private func didTapOnMapBarButtonItem() {
        let navigation = NavigationController(rootViewController: MapViewController())
        presentFull(navigation, animated: true, completion: nil)
    }
    
    private func savePlaces() {
        addPlace(name: "Москальян", metro: "Беляево", address: "ул. Миклухо-Маклая, 18к2", latitude: 55.644902, longitude: 37.519422)
        addPlace(name: "Москальян", metro: "Китай-город", address: "Б. Спасоглинищевский пер. 3с5", latitude: 55.756437, longitude: 37.635188)
        addPlace(name: "Москальян", metro: "Марьино", address: "ул. Люблинская, 165к1", latitude: 55.650063, longitude: 37.745924)
        addPlace(name: "Москальян", metro: "Свиблово", address: "ул. Енисейская, 5к2", latitude: 55.859903, longitude: 37.65911)
    }
    
    private func addPlace(name: String, metro: String, address: String, latitude: Double, longitude: Double) {
        let place = Place()
        place.name = name
        place.metro = metro
        place.latitude = latitude
        place.longitude = longitude
        place.address = address
        RealmService.shared.save(place)
    }
    
    private func cell(at indexPath: IndexPath, viewModel: Place) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainPlaceCell.identifier, for: indexPath) as? MainPlaceCell else {
            return UITableViewCell()
        }
        cell.set(viewModel)
        return cell
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.places.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainPlaceCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(at: indexPath, viewModel: presenter.places[indexPath.row])
    }
}

extension MainViewController {
    private func configureView() {
        title = "Main"
        view.backgroundColor = .white
        
        addMapBarButtonItem()
        addFilterControl()
        addTableView()
    }
    
    private func addMapBarButtonItem() {
        let mapBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "map_marker"),
            style: .plain,
            target: self,
            action: #selector(didTapOnMapBarButtonItem)
        )
        mapBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = mapBarButtonItem
    }
    
    private func addFilterControl() {
        filterControl.insertSegment(withTitle: "By distance", at: 0, animated: false)
        filterControl.insertSegment(withTitle: "By rating", at: 1, animated: false)
        filterControl.tintColor = .black
        filterControl.selectedSegmentIndex = 0
        filterControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterControl)
        
        filterControl.snp.makeConstraints {
            $0.left.right.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    private func addTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.left.bottom.right.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(filterControl.snp.bottom).offset(16)
        }
        
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(MainPlaceCell.self, forCellReuseIdentifier: MainPlaceCell.identifier)
    }
}

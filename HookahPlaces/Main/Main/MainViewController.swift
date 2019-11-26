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
    }
    
    @objc
    private func didTapOnMapBarButtonItem() {
        let navigation = NavigationController(rootViewController: MapViewController())
        presentFull(navigation, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainPlaceCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return mainCell(at: indexPath)
    }
    
    private func mainCell(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPlaceCell.identifier, for: indexPath) as? MainPlaceCell else {
            return UITableViewCell()
        }
        cell.set()
        return cell
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

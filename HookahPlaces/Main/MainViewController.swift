//
//  ViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 26/08/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    private let filterControl = UISegmentedControl()
    private let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
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
        
        addFilterControl()
        addTableView()
    }
    
    private func addFilterControl() {
        filterControl.insertSegment(withTitle: "By distance", at: 0, animated: false)
        filterControl.insertSegment(withTitle: "By rating", at: 1, animated: false)
        filterControl.tintColor = .black
        filterControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterControl)
        
        filterControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        filterControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        filterControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func addTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: filterControl.bottomAnchor, constant: 16).isActive = true
        
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(MainPlaceCell.self, forCellReuseIdentifier: MainPlaceCell.identifier)
    }
}

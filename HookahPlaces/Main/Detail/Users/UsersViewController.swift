//
//  UsersViewController.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 09.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class UsersViewController: UIViewController {
    private var presenter: UsersPresenterProtocol!
    
    private let tableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UsersPresenter(view: self)
        configureView()
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension UsersViewController {
    private func cell(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInPlaceCell.identifier,
                                                       for: indexPath) as? UserInPlaceCell else {
            return UITableViewCell()
        }
        cell.set(presenter.users[indexPath.row])
        return cell
    }
}

extension UsersViewController {
    private func configureView() {
        title = "Пользователи"
        view.backgroundColor = .white
        addTableView()
    }
    
    private func addTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .groupTableViewBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(UserInPlaceCell.self, forCellReuseIdentifier: UserInPlaceCell.identifier)
    }
}

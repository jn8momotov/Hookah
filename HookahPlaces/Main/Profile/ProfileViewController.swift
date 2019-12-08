//
//  ProfileViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    private var presenter: ProfilePresenterProtocol!
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenter(view: self)
        configureView()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.viewModels[indexPath.row].didTapCell?()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
}

extension ProfileViewController {
    private func configureView() {
        title = "Profile"
        view.backgroundColor = .groupTableViewBackground
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
        tableView.register(ProfileImageCell.self, forCellReuseIdentifier: ProfileImageCell.identifier)
        tableView.register(ProfileInfoUserCell.self, forCellReuseIdentifier: ProfileInfoUserCell.identifier)
        tableView.register(ProfileSettingCell.self, forCellReuseIdentifier: ProfileSettingCell.identifier)
        tableView.register(ProfileAuthorizationCell.self, forCellReuseIdentifier: ProfileAuthorizationCell.identifier)
    }
    
    private func cell(at indexPath: IndexPath) -> UITableViewCell {
        let viewModel = presenter.viewModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.identifier,
                                                       for: indexPath) as? ProfileCellProtocol else {
            return UITableViewCell()
        }
        cell.set(viewModel)
        return cell
    }
}

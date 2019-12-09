//
//  AboutViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 20/08/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController {
    private var presenter: AboutPresenterProtocol!
    
    private let iconImageView = UIImageView()
    private let nameAppLabel = UILabel()
    private let versionAppLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AboutPresenter(view: self)
        configureView()
    }
    
    // TODO: Add user agreement
    func pushToUserAgreement() {
        
    }
}

extension AboutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.viewModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.viewModel[indexPath.row].didSelect?()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

extension AboutViewController {
    private func cell(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier,
                                                       for: indexPath) as? AboutCell else {
            return UITableViewCell()
        }
        cell.set(presenter.viewModel[indexPath.row])
        return cell
    }
}

extension AboutViewController {
    private func configureView() {
        title = "О приложении"
        view.backgroundColor = .groupTableViewBackground
        
        addIconImageView()
        addNameAppLabel()
        addVersionAppLabel()
        addTableView()
    }
    
    private func addIconImageView() {
        iconImageView.layer.cornerRadius = 18
        iconImageView.clipsToBounds = true
        //iconImageView.image = #imageLiteral(resourceName: "MTS-Cardio")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(32)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(104)
        }
    }
    
    private func addNameAppLabel() {
        nameAppLabel.text = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
        nameAppLabel.font = .main(ofSize: 24)
        nameAppLabel.textColor = .black
        nameAppLabel.textAlignment = .center
        nameAppLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameAppLabel)
        
        nameAppLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).inset(-14)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func addVersionAppLabel() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        versionAppLabel.text = "Версия приложения: \(version)"
        versionAppLabel.font = .main(ofSize: 14)
        versionAppLabel.textColor = .lightGray
        versionAppLabel.textAlignment = .center
        versionAppLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(versionAppLabel)
        
        versionAppLabel.snp.makeConstraints {
            $0.top.equalTo(nameAppLabel.snp.bottom).inset(-14)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func addTableView() {
        tableView.backgroundColor = .groupTableViewBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(versionAppLabel.snp.bottom).inset(-36)
        }
        
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(AboutCell.self, forCellReuseIdentifier: AboutCell.identifier)
    }
}

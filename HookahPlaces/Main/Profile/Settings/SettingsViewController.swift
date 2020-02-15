//
//  SettingsViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
    private var presenter: SettingsPresenterProtocol!
    
    private let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SettingsPresenter(view: self)
        configureView()
    }
    
    @objc
    private func didTapLogout() {
        let alert = UIAlertController(title: nil, message: "Выйти?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Выйти", style: .destructive) { [weak self] _ in
            self?.presenter.logOut()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        presentFull(alert)
    }
}

extension SettingsViewController {
    private func configureView() {
        title = "Настройки"
        view.backgroundColor = .groupTableViewBackground
        addLogoutButton()
    }
    
    private func addLogoutButton() {
        logoutButton.setTitle("Выход из аккаунта", for: .normal)
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.backgroundColor = .white
        logoutButton.titleLabel?.font = .main(ofSize: 17, weight: .medium)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
            $0.left.right.equalToSuperview()
        }
        
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
    }
}

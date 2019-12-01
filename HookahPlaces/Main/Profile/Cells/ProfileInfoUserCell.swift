//
//  ProfileInfoUserCell.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class ProfileInfoUserCell: UITableViewCell, ProfileCellProtocol {
    static let identifier = String(describing: ProfileInfoUserCell.self)
    
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    
    private var viewModel: ProfileInfoUserViewModel? {
        didSet {
            updateView()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ProfileInfoUserCell.identifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel as? ProfileInfoUserViewModel
    }
    
    private func updateView() {
        nameLabel.text = viewModel?.name
        emailLabel.text = viewModel?.email
    }
}

extension ProfileInfoUserCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        addNameLabel()
        addEmailLabel()
    }
    
    private func addNameLabel() {
        nameLabel.font = .main(ofSize: 17, weight: .medium)
        nameLabel.textColor = .dark
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func addEmailLabel() {
        emailLabel.font = .main(ofSize: 16, weight: .medium)
        emailLabel.textColor = .lightGray
        emailLabel.textAlignment = .center
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}

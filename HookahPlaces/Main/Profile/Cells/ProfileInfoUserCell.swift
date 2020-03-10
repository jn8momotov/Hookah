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
    private let phoneNumberLabel = UILabel()
    
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
        phoneNumberLabel.text = viewModel?.phoneNumber
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
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func addEmailLabel() {
        phoneNumberLabel.font = .main(ofSize: 14)
        phoneNumberLabel.textColor = .lightGray
        phoneNumberLabel.textAlignment = .center
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(phoneNumberLabel)
        
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}

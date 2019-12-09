//
//  UserInPlaceCell.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 09.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class UserInPlaceCell: UITableViewCell {
    static let identifier = String(describing: UserInPlaceCell.self)
    
    private let userImageView = UIImageView()
    private let nameLabel = UILabel()
    private let sendSMSButton = PrimaryButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: UserInPlaceCell.identifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ user: User) {
        nameLabel.text = user.name
    }
}

extension UserInPlaceCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        addImageView()
        addNameLabel()
        addSendSMSButton()
    }
    
    private func addImageView() {
        let size: CGFloat = 60
        userImageView.image = #imageLiteral(resourceName: "user_male")
        userImageView.tintColor = .black
        userImageView.layer.cornerRadius = size / 2
        userImageView.clipsToBounds = true
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userImageView)
        
        userImageView.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview().inset(16)
            $0.height.width.equalTo(size)
        }
    }
    
    private func addNameLabel() {
        nameLabel.font = .main(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(userImageView.snp.right).offset(8)
            $0.top.equalTo(userImageView.snp.top)
            $0.right.equalToSuperview().inset(16)
        }
    }
    
    private func addSendSMSButton() {
        sendSMSButton.setTitle("Написать", for: .normal)
        sendSMSButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sendSMSButton)
        
        sendSMSButton.snp.makeConstraints {
            $0.bottom.equalTo(userImageView.snp.bottom).offset(-4)
            $0.left.equalTo(userImageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
    }
}

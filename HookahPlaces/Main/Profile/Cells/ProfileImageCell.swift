//
//  ProfileImageCell.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class ProfileImageCell: UITableViewCell, ProfileCellProtocol {
    static let identifier = String(describing: ProfileImageCell.self)
    
    private let containerView = UIView()
    private let profileImageView = UIImageView()
    
    private var viewModel: ProfileImageViewModel? {
        didSet {
            updateView()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ProfileImageCell.identifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel as? ProfileImageViewModel
    }
    
    private func updateView() {
        let image = (viewModel?.dataImage != nil) ? UIImage(data: viewModel!.dataImage!) : #imageLiteral(resourceName: "user_male")
        profileImageView.image = image
    }
}

extension ProfileImageCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        addContainerView()
        addProfileImageView()
    }
    
    private func addContainerView() {
        containerView.backgroundColor = .black
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(120)
        }
    }
    
    private func addProfileImageView() {
        let size: CGFloat = 100
        profileImageView.image = #imageLiteral(resourceName: "user_male")
        profileImageView.tintColor = .black
        profileImageView.backgroundColor = .white
        profileImageView.layer.cornerRadius = size / 2
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(containerView.snp.bottom)
            $0.height.width.equalTo(size)
            $0.bottom.equalToSuperview()
        }
    }
}

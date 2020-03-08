//
//  ProfileAuthorizationCell.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class ProfileAuthorizationCell: UITableViewCell, ProfileCellProtocol {
    static let identifier = String(describing: ProfileAuthorizationCell.self)
    
    private let signinButton = PrimaryButton()
    
    private var viewModel: ProfileAuthorizationViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ProfileAuthorizationCell.identifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel as? ProfileAuthorizationViewModel
    }
    
    @objc
    private func didTapOnSignInButton() {
        viewModel?.didTapSignIn?()
    }
}

extension ProfileAuthorizationCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        addSigninButton()
    }
    
    private func addSigninButton() {
        signinButton.setTitle("Войти", for: .normal)
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signinButton)
        
        signinButton.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        signinButton.addTarget(self, action: #selector(didTapOnSignInButton), for: .touchUpInside)
    }
}

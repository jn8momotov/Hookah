//
//  ProfileSettingCell.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class ProfileSettingCell: UITableViewCell, ProfileCellProtocol {
    static let identifier = String(describing: ProfileSettingCell.self)
    
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private var bottomLine: UIView?
    private var topLine: UIView?
    
    private var viewModel: ProfileSettingViewModel? {
        didSet {
            updateView()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ProfileSettingCell.identifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel as? ProfileSettingViewModel
    }
    
    private func updateView() {
        titleLabel.text = viewModel?.title
        addLineToBottom()
        addLineToTop()
    }
}

extension ProfileSettingCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        addArrowImageView()
        addTitleLabel()
    }
    
    private func addTitleLabel() {
        titleLabel.font = .main(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(16)
            $0.right.equalTo(arrowImageView.snp.left).offset(-16)
        }
    }
    
    private func addArrowImageView() {
        arrowImageView.image = #imageLiteral(resourceName: "arrow")
        arrowImageView.tintColor = .lightGray
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(13)
            $0.width.equalTo(7)
        }
    }
    
    private func addLineToTop() {
        guard let viewModel = viewModel, viewModel.topLine, topLine == nil else {
            return
        }
        topLine = UIView()
        topLine!.backgroundColor = .groupTableViewBackground
        topLine!.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topLine!)
        
        topLine!.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func addLineToBottom() {
        guard let viewModel = viewModel, viewModel.bottomLine, bottomLine == nil else {
            return
        }
        bottomLine = UIView()
        bottomLine!.backgroundColor = .groupTableViewBackground
        bottomLine!.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomLine!)
        
        bottomLine!.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

//
//  ProfileSettingCell.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class ProfileSettingCell: RightArrowCell, ProfileCellProtocol {
    static let identifier = String(describing: ProfileSettingCell.self)

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
        set(viewModel?.title ?? "")
        addLineToBottom()
        addLineToTop()
    }
}

extension ProfileSettingCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
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

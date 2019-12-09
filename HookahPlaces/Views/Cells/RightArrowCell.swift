//
//  RightArrowCell.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 09.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

class RightArrowCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ title: String) {
        titleLabel.text = title
    }
}

extension RightArrowCell {
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
}

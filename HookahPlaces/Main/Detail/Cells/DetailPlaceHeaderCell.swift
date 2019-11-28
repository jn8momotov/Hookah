//
//  DetailPlaceHeaderCell.swift
//  HookahPlaces
//
//  Created by Евгений on 28/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class DetailPlaceHeaderCell: UITableViewCell {
    private let placeImageView = UIImageView()
    private let topButtonsStackView = UIStackView()
    private let numberUsersButton = UIButton()
    private let distanceView = MainDistanceView()
    private let callToPlaceButton = UIButton()
    private let checkinPlaceButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapOnCallToPlaceButton() {
        
    }
}

extension DetailPlaceHeaderCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        addPlaceImageView()
        addCallToPlaceButton()
        addTopButtons()
        addCheckinPlaceButton()
    }
    
    private func addPlaceImageView() {
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeImageView)
        
        placeImageView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(180)
        }
    }
    
    private func addCallToPlaceButton() {
        let size: CGFloat = 60
        callToPlaceButton.backgroundColor = .black
        callToPlaceButton.layer.cornerRadius = size / 2
        callToPlaceButton.clipsToBounds = true
        callToPlaceButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(callToPlaceButton)
        
        callToPlaceButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.top.equalTo(placeImageView.snp.bottom).offset(16)
            $0.height.width.equalTo(size)
        }
        
        callToPlaceButton.addTarget(self, action: #selector(didTapOnCallToPlaceButton), for: .touchUpInside)
    }
    
    private func addTopButtons() {
        topButtonsStackView.alignment = .fill
        topButtonsStackView.axis = .horizontal
        topButtonsStackView.distribution = .fillEqually
        topButtonsStackView.spacing = 8
        topButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topButtonsStackView)
        
        topButtonsStackView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.equalTo(placeImageView.snp.bottom).offset(8)
            $0.right.equalTo(callToPlaceButton.snp.left).offset(-16)
            $0.height.equalTo(32)
        }
        
        addNumberUsersButton()
        addDistanceView()
    }
    
    private func addNumberUsersButton() {
        numberUsersButton.layer.cornerRadius = 8
        numberUsersButton.clipsToBounds = true
        numberUsersButton.backgroundColor = .red
        numberUsersButton.translatesAutoresizingMaskIntoConstraints = false
        topButtonsStackView.addArrangedSubview(numberUsersButton)
    }
    
    private func addDistanceView() {
        distanceView.layer.cornerRadius = 8
        distanceView.clipsToBounds = true
        distanceView.backgroundColor = .black
        distanceView.translatesAutoresizingMaskIntoConstraints = false
        topButtonsStackView.addArrangedSubview(distanceView)
    }
    
    private func addCheckinPlaceButton() {
        checkinPlaceButton.setTitle("Вы в заведении", for: .normal)
        checkinPlaceButton.setTitleColor(.white, for: .normal)
        checkinPlaceButton.titleLabel?.font = .main(ofSize: 16, weight: .medium)
        checkinPlaceButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkinPlaceButton)
        
        checkinPlaceButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.equalTo(topButtonsStackView.snp.bottom).offset(8)
            $0.right.equalTo(callToPlaceButton.snp.left).offset(-16)
            $0.height.equalTo(32)
        }
    }
}

//
//  DetailPlaceHeaderCell.swift
//  HookahPlaces
//
//  Created by Евгений on 28/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class DetailPlaceHeaderCell: UITableViewCell, DetailPlaceCellProtocol {
    static let identifier = String(describing: DetailPlaceHeaderCell.self)
    
    private let placeImageView = UIImageView()
    private let topButtonsStackView = UIStackView()
    private let numberUsersView = DetailPlaceInfoView(image: #imageLiteral(resourceName: "people"))
    private let distanceView = DetailPlaceInfoView(image: #imageLiteral(resourceName: "geo_fence"))
    private let callToPlaceButton = UIButton()
    private let checkinPlaceButton = UIButton()
    private let addressLabel = UILabel()
    private let phoneLabel = UILabel()
    
    private var viewModel: DetailPlaceHeaderViewModel? {
        didSet {
            updateView()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ viewModel: DetailPlaceCellViewModelProtocol) {
        self.viewModel = viewModel as? DetailPlaceHeaderViewModel
    }
    
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        // TODO: Set image from view model
        placeImageView.image = #imageLiteral(resourceName: "0")
        distanceView.set("\(viewModel.place.distanceTo) км")
        // TODO: Set title from user
        checkinPlaceButton.setTitle("Вы в заведении", for: .normal)
        numberUsersView.set("\(viewModel.numberUsers)")
        addressLabel.text = "м. \(viewModel.place.metro), \(viewModel.place.address)"
        phoneLabel.text = "Телефон: \(viewModel.place.phone)"
    }
    
    @objc
    private func didTapOnCallToPlaceButton() {
        viewModel?.didTapCall?()
    }
    
    @objc
    private func didTapOnNumberUsersView() {
        viewModel?.didTapNumberUsers?()
    }
    
    @objc
    private func didTapOnCheckinButton() {
        // TODO: Create view model method handler
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
        addAddressLabel()
        addPhoneLabel()
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
        callToPlaceButton.setImage(#imageLiteral(resourceName: "phone"), for: .normal)
        callToPlaceButton.imageView?.tintColor = .white
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
        numberUsersView.layer.cornerRadius = 8
        numberUsersView.clipsToBounds = true
        numberUsersView.backgroundColor = .red
        topButtonsStackView.addArrangedSubview(numberUsersView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnNumberUsersView))
        numberUsersView.addGestureRecognizer(gesture)
    }
    
    private func addDistanceView() {
        distanceView.layer.cornerRadius = 8
        distanceView.clipsToBounds = true
        distanceView.backgroundColor = .black
        topButtonsStackView.addArrangedSubview(distanceView)
    }
    
    private func addCheckinPlaceButton() {
        checkinPlaceButton.backgroundColor = .black
        checkinPlaceButton.layer.cornerRadius = 8
        checkinPlaceButton.clipsToBounds = true
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
        
        checkinPlaceButton.addTarget(self, action: #selector(didTapOnCheckinButton), for: .touchUpInside)
    }
    
    private func addAddressLabel() {
        addressLabel.font = .main(ofSize: 16)
        addressLabel.textColor = .black
        addressLabel.numberOfLines = 0
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(checkinPlaceButton.snp.bottom).offset(16)
        }
    }
    
    private func addPhoneLabel() {
        phoneLabel.font = .main(ofSize: 16)
        phoneLabel.textColor = .black
        phoneLabel.numberOfLines = 0
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(phoneLabel)
        
        phoneLabel.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview().inset(16)
            $0.top.equalTo(addressLabel.snp.bottom).offset(2)
        }
    }
}

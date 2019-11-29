//
//  MainPlaceCell.swift
//  HookahPlaces
//
//  Created by Евгений on 26/08/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class MainPlaceCell: UITableViewCell {
    static let identifier = String(describing: MainPlaceCell.self)
    static let height: CGFloat = 160
    
    private let containerView = UIView()
    private let placeImageView = UIImageView()
    
    private let containerMainInfoView = UIView()
    private let namePlaceLabel = UILabel()
    private let addressPlaceLabel = UILabel()
    
    private let ratingView = MainRatingView()
    private let distanceView = MainDistanceView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MainPlaceCell.identifier)
        configureViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ place: Place) {
        placeImageView.image = #imageLiteral(resourceName: "0")
        namePlaceLabel.text = "\(place.name) \(place.metro)"
        addressPlaceLabel.text = "\(place.address)"
        ratingView.set(rating: place.rating?.rating ?? 0.0)
        distanceView.set(distance: place.distanceTo)
    }
}

extension MainPlaceCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        addContainerView()
    }
    
    private func addContainerView() {
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        
        addPlaceImageView()
        addMainInfoView()
        addRatingView()
        addDistanceView()
    }
    
    private func addPlaceImageView() {
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(placeImageView)
        
        placeImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        placeImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        placeImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        placeImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    private func addMainInfoView() {
        containerMainInfoView.backgroundColor = .black
        containerMainInfoView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(containerMainInfoView)
        
        containerMainInfoView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        containerMainInfoView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        containerMainInfoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        containerMainInfoView.heightAnchor.constraint(equalToConstant: MainPlaceCell.height / 3).isActive = true
        
        addNameLabel()
        addAddressLabel()
    }
    
    private func addNameLabel() {
        namePlaceLabel.font = .main(ofSize: 16)
        namePlaceLabel.textColor = .white
        namePlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        containerMainInfoView.addSubview(namePlaceLabel)
        
        namePlaceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        namePlaceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        namePlaceLabel.topAnchor.constraint(equalTo: containerMainInfoView.topAnchor, constant: 8).isActive = true
    }
    
    private func addAddressLabel() {
        addressPlaceLabel.font = .main(ofSize: 14)
        addressPlaceLabel.textColor = .white
        addressPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        containerMainInfoView.addSubview(addressPlaceLabel)
        
        addressPlaceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        addressPlaceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        addressPlaceLabel.topAnchor.constraint(equalTo: namePlaceLabel.bottomAnchor, constant: 2).isActive = true
    }
    
    private func addRatingView() {
        ratingView.layer.cornerRadius = 8
        ratingView.layer.borderColor = UIColor.white.cgColor
        ratingView.layer.borderWidth = 2
        ratingView.clipsToBounds = true
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(ratingView)
        
        ratingView.snp.makeConstraints {
            $0.right.top.equalToSuperview().inset(16)
            $0.height.equalTo(26)
        }
    }
    
    private func addDistanceView() {
        distanceView.layer.cornerRadius = 8
        distanceView.layer.borderColor = UIColor.white.cgColor
        distanceView.layer.borderWidth = 2
        distanceView.clipsToBounds = true
        distanceView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(distanceView)
        
        distanceView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.right.equalTo(ratingView.snp.left).offset(-16)
            $0.height.equalTo(26)
        }
    }
}

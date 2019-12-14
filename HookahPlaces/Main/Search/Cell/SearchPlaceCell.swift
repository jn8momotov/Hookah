//
//  SearchPlaceCell.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class SearchPlaceCell: UITableViewCell {
    static let identifier = String(describing: SearchPlaceCell.self)
    
    private let placeImageView = UIImageView()
    private let titleLabel = UILabel()
    private let ratingView = DetailPlaceInfoView(image: #imageLiteral(resourceName: "star"))
    private let distanceView = DetailPlaceInfoView(image: #imageLiteral(resourceName: "geo_fence"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SearchPlaceCell.identifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ place: Place) {
        if let dataImage = place.image {
            placeImageView.image = UIImage(data: dataImage)
        }
        titleLabel.text = "\(place.name) \(place.location?.metro ?? "")"
        distanceView.set("\(place.location?.distanceTo ?? 0.0) км")
        ratingView.set("\(place.rating?.total ?? 0.0)")
    }
}

extension SearchPlaceCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        addImageView()
        addTitleLabel()
        addDistanceView()
        addRatingView()
    }
    
    private func addImageView() {
        let size: CGFloat = 54
        placeImageView.layer.cornerRadius = size / 2
        placeImageView.clipsToBounds = true
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeImageView)
        
        placeImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(size)
        }
    }
    
    private func addTitleLabel() {
        titleLabel.font = .main(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(placeImageView.snp.right).offset(16)
            $0.top.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
        }
    }
    
    private func addRatingView() {
        ratingView.valueLabel.font = .main(ofSize: 14)
        ratingView.layer.cornerRadius = 8
        ratingView.clipsToBounds = true
        ratingView.backgroundColor = .black
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingView)
        
        ratingView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalTo(distanceView.snp.right).offset(16)
            $0.height.equalTo(26)
            $0.width.equalTo(90)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func addDistanceView() {
        distanceView.valueLabel.font = .main(ofSize: 14)
        distanceView.layer.cornerRadius = 8
        distanceView.clipsToBounds = true
        distanceView.backgroundColor = .black
        distanceView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(distanceView)
        
        distanceView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalTo(placeImageView.snp.right).offset(16)
            $0.height.equalTo(26)
            $0.width.equalTo(90)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}

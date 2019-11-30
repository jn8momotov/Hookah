//
//  MapDetailPlaceView.swift
//  HookahPlaces
//
//  Created by Евгений on 26/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class MapPlaceView: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let addressLabel = UILabel()
    private let detailButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ place: Place) {
        titleLabel.text = "\(place.name) \(place.location?.metro ?? "")"
        addressLabel.text = place.location?.address
        if let data = place.image {
            imageView.image = UIImage(data: data)
        }
    }
}

extension MapPlaceView {
    private func configure() {
        backgroundColor = .white
        addImageView()
        addTitleLabel()
        addAddressLabel()
        addDetailButton()
    }
    
    private func addImageView() {
        let size: CGFloat = 80
        imageView.layer.cornerRadius = size / 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(size)
        }
    }
    
    private func addTitleLabel() {
        titleLabel.font = .main(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.top.equalTo(imageView.snp.top)
            $0.right.equalToSuperview().inset(16)
        }
    }
    
    private func addAddressLabel() {
        addressLabel.font = .main(ofSize: 14)
        addressLabel.textColor = .black
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.right.equalToSuperview().inset(16)
        }
    }
    
    private func addDetailButton() {
        detailButton.titleLabel?.font = .main(ofSize: 16, weight: .medium)
        detailButton.setTitle("Detail", for: .normal)
        detailButton.setTitleColor(.white, for: .normal)
        detailButton.backgroundColor = .black
        detailButton.layer.cornerRadius = 6
        detailButton.clipsToBounds = true
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailButton)
        
        detailButton.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.top.equalTo(addressLabel.snp.bottom).offset(8)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(32)
        }
    }
}

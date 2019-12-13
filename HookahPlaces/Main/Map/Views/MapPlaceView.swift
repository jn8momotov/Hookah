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
    private let detailButton = PrimaryButton()
    private let callButton = PrimaryButton()
    private let routeButton = PrimaryButton()
    
    var didTapCall: DidTapHandler?
    var didTapRoute: DidTapHandler?
    var didTapDetail: DidTapHandler?
    
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
    
    @objc
    private func didTapOnCall() {
        didTapCall?()
    }
    
    @objc
    private func didTapOnRoute() {
        didTapRoute?()
    }
    
    @objc
    private func didTapOnDetail() {
        didTapDetail?()
    }
}

extension MapPlaceView {
    private func configure() {
        backgroundColor = .white
        addImageView()
        addTitleLabel()
        addAddressLabel()
        addCallButton()
        addRouteButton()
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
    
    private func addCallButton() {
        callButton.setImage(#imageLiteral(resourceName: "phone"), for: .normal)
        callButton.imageView?.tintColor = .white
        callButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(callButton)
        
        callButton.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(8)
            $0.right.equalToSuperview().inset(16)
            $0.height.width.equalTo(32)
        }
        
        callButton.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }
        
        callButton.addTarget(self, action: #selector(didTapOnCall), for: .touchUpInside)
    }
    
    private func addRouteButton() {
        routeButton.setImage(#imageLiteral(resourceName: "geo_fence"), for: .normal)
        routeButton.imageView?.tintColor = .white
        routeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(routeButton)
        
        routeButton.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(8)
            $0.right.equalTo(callButton.snp.left).offset(-8)
            $0.height.width.equalTo(32)
        }
        
        routeButton.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }
        
        routeButton.addTarget(self, action: #selector(didTapOnRoute), for: .touchUpInside)
    }
    
    private func addDetailButton() {
        detailButton.setTitle("Открыть", for: .normal)
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailButton)
        
        detailButton.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.top.equalTo(addressLabel.snp.bottom).offset(8)
            $0.right.equalTo(routeButton.snp.left).offset(-8)
            $0.height.equalTo(32)
        }
        
        detailButton.addTarget(self, action: #selector(didTapOnDetail), for: .touchUpInside)
    }
}

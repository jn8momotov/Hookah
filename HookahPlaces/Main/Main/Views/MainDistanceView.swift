//
//  MainDistanceView.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class MainDistanceView: UIView {
    private let distanceImageView = UIImageView()
    private let distanceLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(distance: Float) {
        distanceLabel.text = "\(distance) km"
    }
}

extension MainDistanceView {
    private func configureView() {
        backgroundColor = .black
        addImageView()
        addDistanceLabel()
    }
    
    private func addImageView() {
        distanceImageView.image = #imageLiteral(resourceName: "geo_fence")
        distanceImageView.tintColor = .white
        distanceImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(distanceImageView)
        
        distanceImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(8)
            $0.height.width.equalTo(16)
        }
    }
    
    private func addDistanceLabel() {
        distanceLabel.font = .main(ofSize: 14)
        distanceLabel.textColor = .white
        distanceLabel.textAlignment = .center
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(distanceLabel)
        
        distanceLabel.snp.makeConstraints {
            $0.left.equalTo(distanceImageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }
}

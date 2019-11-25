//
//  MainRatingView.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class MainRatingView: UIView {
    private let ratingImageView = UIImageView()
    private let ratingLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(rating: Float) {
        ratingLabel.text = "\(rating)"
    }
}

extension MainRatingView {
    private func configureView() {
        backgroundColor = .black
        addImageView()
        addRatingLabel()
    }
    
    private func addImageView() {
        ratingImageView.image = #imageLiteral(resourceName: "star")
        ratingImageView.tintColor = .yellow
        ratingImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingImageView)
        
        ratingImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(8)
            $0.height.width.equalTo(16)
        }
    }
    
    private func addRatingLabel() {
        ratingLabel.font = .main(ofSize: 14)
        ratingLabel.textColor = .white
        ratingLabel.textAlignment = .center
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingLabel)
        
        ratingLabel.snp.makeConstraints {
            $0.left.equalTo(ratingImageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }
}

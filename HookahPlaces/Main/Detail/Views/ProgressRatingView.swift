//
//  ProgressRatingView.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 29.11.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class ProgressRatingView: UIView {
    private let titleLabel = UILabel()
    private let ratingProgress = UIProgressView()
    private let ratingLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ model: RatingViewModel) {
        titleLabel.text = model.title
        ratingProgress.progress = model.rating / 5.0
        ratingLabel.text = "\(model.rating)"
    }
}

extension ProgressRatingView {
    private func configureView() {
        addTitleLabel()
        addRatingLabel()
        addRatingProgress()
    }
    
    private func addTitleLabel() {
        titleLabel.font = .main(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }
    }
    
    private func addRatingProgress() {
        ratingProgress.progressTintColor = .black
        ratingProgress.tintColor = .groupTableViewBackground
        ratingProgress.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingProgress)
        
        ratingProgress.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(titleLabel.snp.right).offset(8)
            $0.right.equalTo(ratingLabel.snp.left).offset(-16)
            $0.height.equalTo(4)
        }
    }
    
    private func addRatingLabel() {
        ratingLabel.font = .main(ofSize: 16)
        ratingLabel.textColor = .black
        ratingLabel.textAlignment = .center
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingLabel)
        
        ratingLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}

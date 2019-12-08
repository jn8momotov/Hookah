//
//  NewRatingView.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class NewRatingView: UIView {
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private var buttons: [StarButton] = []
    
    var didSelectRating: ((Int) -> Void)?
    
    init(title: String) {
        super.init(frame: .zero)
        configureView()
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapOnStarButton(_ sender: StarButton) {
        var index = 1
        while index <= sender.tag {
            guard let starSubview = stackView.arrangedSubviews[index - 1] as? StarButton else {
                continue
            }
            starSubview.isActive = true
            index += 1
        }
        while index <= stackView.arrangedSubviews.count {
            guard let starSubview = stackView.arrangedSubviews[index - 1] as? StarButton else {
                continue
            }
            starSubview.isActive = false
            index += 1
        }
        didSelectRating?(sender.tag)
    }
}

extension NewRatingView {
    private func configureView() {
        backgroundColor = .white
        addTitleLabel()
        addStackView()
    }
    
    private func addTitleLabel() {
        titleLabel.font = .main(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    private func addStackView() {
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        let width = (StarButton.size * 5) + (stackView.spacing * 4)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(StarButton.size)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        addStarButtons()
    }
    
    private func addStarButtons() {
        for index in 1...5 {
            let button = StarButton()
            button.tag = index
            stackView.addArrangedSubview(button)
            
            button.snp.makeConstraints {
                $0.height.width.equalTo(StarButton.size)
            }
            
            button.addTarget(self, action: #selector(didTapOnStarButton(_:)), for: .touchUpInside)
        }
    }
}

//
//  DetailPlaceInfoView.swift
//  HookahPlaces
//
//  Created by Евгений on 30/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class DetailPlaceInfoView: UIView {
    let valueLabel = UILabel()
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    
    init(image: UIImage) {
        super.init(frame: .zero)
        configureView()
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ text: String) {
        valueLabel.text = text
    }
}

extension DetailPlaceInfoView {
    private func configureView() {
        addStackView()
        addImageView()
        addValueLabel()
    }
    
    private func addStackView() {
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(6)
        }
    }
    
    private func addImageView() {
        imageView.tintColor = .white
        stackView.addArrangedSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(imageView.snp.height)
        }
    }
    
    private func addValueLabel() {
        valueLabel.font = .main(ofSize: 16)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        stackView.addArrangedSubview(valueLabel)
    }
}

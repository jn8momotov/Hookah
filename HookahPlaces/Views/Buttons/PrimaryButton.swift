//
//  PrimaryButton.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 29.11.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class PrimaryButton: UIButton {
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrimaryButton {
    private func configureView() {
        titleLabel?.font = .main(ofSize: 16)
        backgroundColor = .black
        layer.cornerRadius = 6
        clipsToBounds = true
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
    }
}

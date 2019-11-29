//
//  OutlinedButton.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 29.11.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class OutlinedButton: UIButton {
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OutlinedButton {
    private func configureView() {
        titleLabel?.font = .main(ofSize: 16)
        setTitleColor(.black, for: .normal)
        setTitleColor(UIColor.black.withAlphaComponent(0.5), for: .highlighted)
        backgroundColor = .white
        layer.cornerRadius = 6
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
    }
}

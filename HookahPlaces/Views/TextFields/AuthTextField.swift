//
//  AuthTextField.swift
//  HookahPlaces
//
//  Created by Евгений on 08/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class AuthTextField: UITextField {
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthTextField {
    private func configureView() {
        font = .main(ofSize: 16)
        textColor = .black
        backgroundColor = .white
        layer.cornerRadius = 6
        clipsToBounds = true
        borderStyle = .roundedRect
    }
}

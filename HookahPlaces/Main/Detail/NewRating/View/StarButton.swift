//
//  StarButton.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class StarButton: UIButton {
    static let size: CGFloat = 44
    
    var isActive: Bool = false {
        didSet {
            updateActive()
        }
    }
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StarButton {
    private func configureView() {
        backgroundColor = .white
        tintColor = .black
        updateActive()
    }
    
    private func updateActive() {
        let image = isActive ? #imageLiteral(resourceName: "star") : #imageLiteral(resourceName: "unselected-star")
        setBackgroundImage(image, for: .normal)
    }
}

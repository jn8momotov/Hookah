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
}

extension MainDistanceView {
    private func configureView() {
        backgroundColor = .black
        addImageView()
    }
    
    private func addImageView() {
        
    }
    
    private func addDistanceLabel() {
        
    }
}

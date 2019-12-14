//
//  InputValuePlaceView.swift
//  HookahPlaces
//
//  Created by Евгений on 15/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class InputValuePlaceView: UIView {
    private let titleLabel = UILabel()
    private let textField = AuthTextField()
    
    var text: String {
        return textField.text ?? ""
    }
    
    init(title: String) {
        super.init(frame: .zero)
        configureView()
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputValuePlaceView {
    private func configureView() {
        addTitleLabel()
        addTextField()
    }
    
    private func addTitleLabel() {
        titleLabel.font = .main(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    private func addTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}

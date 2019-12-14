//
//  SearchView.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class SearchView: UIView {
    let textField = UITextField()
    
    private let searchImageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    private func configureView() {
        backgroundColor = .white
        addSearchImageView()
        addTextField()
    }
    
    private func addSearchImageView() {
        searchImageView.image = #imageLiteral(resourceName: "search")
        searchImageView.tintColor = .black
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchImageView)
        
        searchImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(22)
        }
    }
    
    private func addTextField() {
        textField.font = .main(ofSize: 16)
        textField.placeholder = "Название или метро"
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.left.equalTo(searchImageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview()
        }
    }
}

//
//  DetailPlaceAdditionalDataCell.swift
//  HookahPlaces
//
//  Created by Евгений on 29/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class DetailPlaceAdditionalDataCell: UITableViewCell, DetailPlaceCellProtocol {
    static let identifier = String(describing: DetailPlaceAdditionalDataCell.self)
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    private var viewModel: DetailPlaceAdditionalViewModel? {
        didSet {
            updateView()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: DetailPlaceAdditionalDataCell.identifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ viewModel: DetailPlaceCellViewModelProtocol) {
        self.viewModel = viewModel as? DetailPlaceAdditionalViewModel
    }
    
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.additional.rawValue
        valueLabel.text = viewModel.value ? "Да" : "Нет"
    }
}

extension DetailPlaceAdditionalDataCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        addTitleLabel()
        addValueLabel()
    }
    
    private func addTitleLabel() {
        titleLabel.font = .main(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(6)
        }
    }
    
    private func addValueLabel() {
        valueLabel.font = .main(ofSize: 16)
        valueLabel.textColor = .gray
        valueLabel.textAlignment = .right
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
        
        valueLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(6)
            $0.left.equalTo(titleLabel.snp.right).offset(8)
        }
    }
}

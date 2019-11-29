//
//  DetailPlaceRatingCell.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 29.11.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class DetailPlaceRatingCell: UITableViewCell, DetailPlaceCellProtocol {
    static let identifier = String(describing: DetailPlaceRatingCell.self)
    
    private let ratingLabel = UILabel()
    private let ratingHookahView = ProgressRatingView()
    private let ratingStaffView = ProgressRatingView()
    private let ratingPlaceView = ProgressRatingView()
    private let numberRatingsLabel = UILabel()
    private let addRatingButton = OutlinedButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: DetailPlaceRatingCell.identifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel: DetailPlaceRatingViewModel? {
        didSet {
            updateView()
        }
    }
    
    func set(_ viewModel: DetailPlaceCellViewModelProtocol) {
        self.viewModel = viewModel as? DetailPlaceRatingViewModel
    }
    
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        ratingLabel.text = "\(viewModel.rating)"
        ratingHookahView.set(viewModel.hookah)
        ratingPlaceView.set(viewModel.place)
        ratingStaffView.set(viewModel.staff)
        numberRatingsLabel.text = "Всего оценок: \(viewModel.numberRatings)"
    }
}

extension DetailPlaceRatingCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        addRatingLabel()
        addRatingHookahView()
        addRatingStaffView()
        addRatingPlaceView()
        addNumberRatingsLabel()
        addButton()
    }
    
    private func addRatingLabel() {
        ratingLabel.font = .main(ofSize: 50, weight: .bold)
        ratingLabel.textColor = .black
        ratingLabel.textAlignment = .center
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingLabel)
        
        ratingLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
        }
    }
    
    private func addRatingHookahView() {
        ratingHookahView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingHookahView)
        
        ratingHookahView.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(32)
        }
    }
    
    private func addRatingStaffView() {
        ratingStaffView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingStaffView)
        
        ratingStaffView.snp.makeConstraints {
            $0.top.equalTo(ratingHookahView.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(32)
        }
    }
    
    private func addRatingPlaceView() {
        ratingPlaceView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingPlaceView)
        
        ratingPlaceView.snp.makeConstraints {
            $0.top.equalTo(ratingStaffView.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(32)
        }
    }
    
    private func addNumberRatingsLabel() {
        numberRatingsLabel.font = .main(ofSize: 14)
        numberRatingsLabel.textColor = .black
        numberRatingsLabel.textAlignment = .center
        numberRatingsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(numberRatingsLabel)
        
        numberRatingsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(ratingPlaceView.snp.bottom).offset(8)
        }
    }
    
    private func addButton() {
        addRatingButton.setTitle("Оценить", for: .normal)
        addRatingButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addRatingButton)
        
        addRatingButton.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview().inset(16)
            $0.top.equalTo(numberRatingsLabel.snp.bottom).offset(8)
            $0.height.equalTo(32)
        }
    }
}

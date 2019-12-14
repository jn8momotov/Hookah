//
//  AlertViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 15/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class AlertViewController: UIViewController {
    private let containerView = UIView()
    private let descriptionLabel = UILabel()
    private let titleLabel = UILabel()
    private let defaultButton = PrimaryButton()

    var titleText: String?
    var descriptionText: String?
    var completion: DidTapHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    @objc
    private func didTapDefaultButton() {
        dismiss(animated: true, completion: completion)
    }
}

extension AlertViewController {
    private func configureView() {
        addContainerView()
        addDefaultButton()
        addDescriptionLabel()
        addTitleLabel()
    }
    
    private func addContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func addDefaultButton() {
        defaultButton.setTitle("Понятно", for: .normal)
        defaultButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(defaultButton)
        
        defaultButton.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        defaultButton.addTarget(self, action: #selector(didTapDefaultButton), for: .touchUpInside)
    }
    
    private func addDescriptionLabel() {
        descriptionLabel.text = descriptionText
        descriptionLabel.font = .main(ofSize: 16)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(defaultButton.snp.top).offset(-16)
        }
    }
    
    private func addTitleLabel() {
        titleLabel.text = titleText
        titleLabel.font = .main(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.right.top.equalToSuperview().inset(16)
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-8)
        }
    }
}

//
//  AddingPlaceViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 15/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class AddingPlaceViewController: UIViewController {
    private var presenter: AddingPlacePresenter!
    
    private let inputNameView = InputValuePlaceView(title: "Название")
    private let inputAddressView = InputValuePlaceView(title: "Адрес")
    private let inputCommentView = InputValuePlaceView(title: "Комментарий")
    private let addingButton = PrimaryButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddingPlacePresenterImpl(view: self)
        configureView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc
    private func didTapSendButton() {
        
    }
}

extension AddingPlaceViewController {
    private func configureView() {
        title = "Новое заведение"
        view.backgroundColor = .white
        addNameView()
        addAddressView()
        addCommentView()
        addButton()
        
    }
    
    private func addNameView() {
        inputNameView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputNameView)
        
        inputNameView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
    
    private func addAddressView() {
        inputAddressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputAddressView)
        
        inputAddressView.snp.makeConstraints {
            $0.top.equalTo(inputNameView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
    }
    
    private func addCommentView() {
        inputCommentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputCommentView)
        
        inputCommentView.snp.makeConstraints {
            $0.top.equalTo(inputAddressView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
    }
    
    private func addButton() {
        addingButton.setTitle("Отправить", for: .normal)
        addingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addingButton)
        
        addingButton.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        addingButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
}

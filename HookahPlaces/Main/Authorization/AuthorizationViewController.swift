//
//  InputPhoneNumberViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 08/03/2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    private var presenter: AuthorizationPresenter!
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let phoneNumberTextField = UITextField()
    private let codeLabel = UILabel()
    private let codeTextField = UITextField()
    private let doneButton = PrimaryButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AuthorizationPresenterImpl(view: self)
        configureView()
    }
    
    func updateViewAfterVerifyPhoneNumber() {
        codeTextField.isHidden = false
        codeLabel.isHidden = false
        doneButton.setTitle("Войти", for: .normal)
    }
    
    @objc
    private func didTapDoneButton() {
        guard let textPhoneNumber = phoneNumberTextField.text,
            let phoneNumber = presenter.isCorrectPhone(textPhoneNumber) else {
                showAlert(title: "Ошибка ввода!", description: "Номер телефона заполнен некорректно")
                return
        }
        
        presenter.didTapDone(phoneNumber: "+" + phoneNumber, codeSMS: codeTextField.text ?? "")
    }
}

extension AuthorizationViewController {
    private func configureView() {
        title = "Вход"
        view.backgroundColor = .white
        addTitleLabel()
        addDescriptionLabel()
        addPhoneNumberLabel()
        addPhoneNumberTextField()
        addCodeLabel()
        addCodeTextField()
        addDoneButton()
        addCancelBarButtonItem()
    }
    
    private func addTitleLabel() {
        titleLabel.text = "Добро пожаловать!"
        titleLabel.font = .main(ofSize: 20, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.right.top.equalToSuperview().inset(16)
        }
    }
    
    private func addDescriptionLabel() {
        descriptionLabel.text = "СМС может приходить до нескольких минут. В ближайших обновлениях все исправим"
        descriptionLabel.font = .main(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    private func addPhoneNumberLabel() {
        phoneNumberLabel.text = "Телефон"
        phoneNumberLabel.font = .main(ofSize: 14, weight: .bold)
        phoneNumberLabel.textColor = .black
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneNumberLabel)
        
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    private func addPhoneNumberTextField() {
        phoneNumberTextField.placeholder = "Номер телефона"
        phoneNumberTextField.font = .main(ofSize: 17)
        phoneNumberTextField.textColor = .black
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.textContentType = .telephoneNumber
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneNumberTextField)
        
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        let line = UIView()
        line.backgroundColor = .black
        line.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.addSubview(line)
        
        line.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    private func addCodeLabel() {
        codeLabel.isHidden = true
        codeLabel.text = "Код"
        codeLabel.font = .main(ofSize: 14, weight: .bold)
        codeLabel.textColor = .black
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(codeLabel)
        
        codeLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    private func addCodeTextField() {
        codeTextField.isHidden = true
        codeTextField.placeholder = "Код из СМС"
        codeTextField.font = .main(ofSize: 17)
        codeTextField.textColor = .black
        codeTextField.keyboardType = .numberPad
        if #available(iOS 12.0, *) {
            codeTextField.textContentType = .oneTimeCode
        }
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(codeTextField)
        
        codeTextField.snp.makeConstraints {
            $0.top.equalTo(codeLabel.snp.bottom)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        let line = UIView()
        line.backgroundColor = .black
        line.translatesAutoresizingMaskIntoConstraints = false
        codeTextField.addSubview(line)
        
        line.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    private func addDoneButton() {
        doneButton.setTitle("Отправить СМС", for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneButton)
        
        doneButton.snp.makeConstraints {
            $0.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
    }
}

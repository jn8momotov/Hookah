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
    
    private let phoneNumberTextField = UITextField()
    private let codeTextField = UITextField()
    private let doneButton = PrimaryButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AuthorizationPresenterImpl(view: self)
        configureView()
    }
    
    func updateViewAfterVerifyPhoneNumber() {
        codeTextField.isHidden = false
        doneButton.setTitle("Войти", for: .normal)
    }
    
    @objc
    private func didTapDoneButton() {
        guard let textPhoneNumber = phoneNumberTextField.text,
            let phoneNumber = presenter.isCorrectPhone(textPhoneNumber) else {
                showAlert(title: "Ошибка ввода!", description: "Номер телефона заполнен некорректно!")
                return
        }
        
        presenter.didTapDone(phoneNumber: "+" + phoneNumber, codeSMS: codeTextField.text ?? "")
    }
}

extension AuthorizationViewController {
    private func configureView() {
        title = "Вход"
        view.backgroundColor = .white
        addPhoneNumberTextField()
        addCodeTextField()
        addDoneButton()
        addCancelBarButtonItem()
    }
    
    private func addPhoneNumberTextField() {
        phoneNumberTextField.placeholder = "Номер телефона"
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.font = .main(ofSize: 17)
        phoneNumberTextField.textColor = .black
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneNumberTextField)
        
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    private func addCodeTextField() {
        codeTextField.isHidden = true
        codeTextField.placeholder = "Код из СМС"
        codeTextField.font = .main(ofSize: 17)
        codeTextField.textColor = .black
        codeTextField.borderStyle = .roundedRect
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(codeTextField)
        
        codeTextField.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
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

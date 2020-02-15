//
//  SignupViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 08/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class SignupViewController: UIViewController {
    private var presenter: SignupPresenterProtocol!
    
    private let userImageView = UIImageView()
    private let nameTextField = AuthTextField()
    private let emailTextField = AuthTextField()
    private let phoneTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let userAgreementLabel = UILabel()
    private let userAgreementSwitch = UISwitch()
    private let signupButton = PrimaryButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignupPresenter(view: self)
        configureView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // TODO: Saved photo
    @objc
    private func didTapSignUp() {
        view.endEditing(true)
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let name = nameTextField.text,
            let phone = phoneTextField.text else {
            return
        }
        let model = SignUpModel(isAccept: userAgreementSwitch.isOn,
                                photo: nil,
                                name: name,
                                phone: phone,
                                signInModel: SignInModel(email: email, password: password))
        presenter.signUp(model)
    }
}

extension SignupViewController {
    private func configureView() {
        title = "Регистрация"
        view.backgroundColor = .white
        addUserImageView()
        addNameTextField()
        addEmailTextField()
        addPhoneTextField()
        addPasswordTextField()
        addUserAgreementView()
        addSignUpButton()
        if navigationController?.viewControllers.count ?? 1 < 2 {
            addCancelBarButtonItem()
        }
    }
    
    private func addUserImageView() {
        let size: CGFloat = 80
        userImageView.image = #imageLiteral(resourceName: "user_male")
        userImageView.tintColor = .black
        userImageView.layer.cornerRadius = size / 2
        userImageView.layer.borderWidth = 3
        userImageView.layer.borderColor = UIColor.black.cgColor
        userImageView.clipsToBounds = true
        view.addSubview(userImageView)
        
        userImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(size)
        }
    }
    
    private func addNameTextField() {
        nameTextField.placeholder = "Имя"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    private func addEmailTextField() {
        emailTextField.placeholder = "E-mail"
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    private func addPhoneTextField() {
        phoneTextField.placeholder = "Номер телефона"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneTextField)
        
        phoneTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    private func addPasswordTextField() {
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(phoneTextField.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    private func addUserAgreementView() {
        userAgreementLabel.text = "Принять пользовательское соглашение"
        userAgreementLabel.font = .main(ofSize: 14)
        userAgreementLabel.textColor = .black
        userAgreementLabel.numberOfLines = 0
        userAgreementLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userAgreementLabel)
        
        userAgreementLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(80)
        }
        
        userAgreementSwitch.onTintColor = .black
        userAgreementSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userAgreementSwitch)
        
        userAgreementSwitch.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalTo(userAgreementLabel.snp.centerY)
        }
    }
    
    private func addSignUpButton() {
        signupButton.setTitle("Зарегистрироваться", for: .normal)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupButton)
        
        signupButton.snp.makeConstraints {
            $0.left.bottom.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        signupButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
}

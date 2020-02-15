//
//  SigninViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 08/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class SigninViewController: UIViewController {
    private var presenter: SigninPresenterProtocol!
    
    private let emailTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let signinButton = PrimaryButton()
    private let signupButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SigninPresenter(view: self)
        configureView()
    }
    
    // TODO: Logic sign in
    @objc
    private func didTapSignInButton() {
        view.endEditing(true)
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text else {
            return
        }
        presenter.signIn(email: email, password: password)
    }
    
    // TODO: Open sign up
    @objc
    private func didTapSignUpButton() {
        view.endEditing(true)
        presenter.showSignUp()
    }
}

extension SigninViewController {
    private func configureView() {
        title = "Вход"
        view.backgroundColor = .white
        setBackBarButtonItem()
        addEmailTextField()
        addPasswordTextField()
        addSigninButton()
        addSignupButton()
        addCancelBarButtonItem()
    }
    
    private func addEmailTextField() {
        emailTextField.placeholder = "E-mail"
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints {
            $0.left.top.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    private func addPasswordTextField() {
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    private func addSigninButton() {
        signinButton.setTitle("Войти", for: .normal)
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signinButton)
        
        signinButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        signinButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
    }
    
    private func addSignupButton() {
        signupButton.setTitle("Зарегистрироваться", for: .normal)
        signupButton.titleLabel?.font = .main(ofSize: 16, weight: .bold)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupButton)
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(signinButton.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        signupButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }
}

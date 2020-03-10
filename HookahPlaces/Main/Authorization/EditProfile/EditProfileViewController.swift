//
//  EditProfileViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 09/03/2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import UIKit

final class EditProfileViewController: UIViewController {
    private var presenter: EditProfilePresenter!
    
    private let userImageView = UIImageView()
    private let nameLabel = UILabel()
    private let nameTextField = UITextField()
    private let saveButton = PrimaryButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = EditProfilePresenterImpl(view: self)
        configureView()
    }
    
    @objc
    private func didTapUserImage() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = .black
        
        var onDelete: VoidHandler?
        
        if userImageView.image != #imageLiteral(resourceName: "user_male") {
            onDelete = { [weak self] in
                self?.userImageView.image = #imageLiteral(resourceName: "user_male")
            }
        }
        
        showCameraAlert(onDelete: onDelete)
    }
    
    @objc
    private func didTapSaveButton() {
        let image = userImageView.image != #imageLiteral(resourceName: "user_male") ? userImageView.image: nil
        presenter.save(image: image, name: nameTextField.text)
    }
    
    private func showCameraAlert(onDelete: VoidHandler?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = .black
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { [weak self] _ in
            self?.showImageController(sourceType: .camera)
        }
        let libraryAction = UIAlertAction(title: "Выбрать фото", style: .default) { [weak self] _ in
            self?.showImageController(sourceType: .photoLibrary)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        
        if let onDelete = onDelete {
            let removeAction = UIAlertAction(title: "Удалить фото", style: .destructive) { _ in
                onDelete()
            }
            alert.addAction(removeAction)
        }
        
        presentFull(alert)
    }
    
    private func showImageController(sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.delegate = self
        presentFull(controller)
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        let dataImage = selectedImage.jpegData(compressionQuality: 1)
        userImageView.image = (dataImage != nil) ? UIImage(data: dataImage!) : #imageLiteral(resourceName: "user_male")
        dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController {
    private func configureView() {
        view.backgroundColor = .white
        addUserImageView()
        addNameLabel()
        addNameTextField()
        addSaveButton()
    }
    
    private func addUserImageView() {
        let size: CGFloat = 80
        userImageView.image = #imageLiteral(resourceName: "user_male")
        userImageView.isUserInteractionEnabled = true
        userImageView.tintColor = .black
        userImageView.layer.cornerRadius = size / 2
        userImageView.layer.borderWidth = 3
        userImageView.layer.borderColor = UIColor.black.cgColor
        userImageView.clipsToBounds = true
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userImageView)
        
        userImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(size)
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapUserImage))
        userImageView.addGestureRecognizer(gesture)
    }
    
    private func addNameLabel() {
        nameLabel.text = "Ваше имя"
        nameLabel.font = .main(ofSize: 14, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    private func addNameTextField() {
        nameTextField.placeholder = "Имя"
        nameTextField.font = .main(ofSize: 17)
        nameTextField.textColor = .black
        nameTextField.textContentType = .name
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        let line = UIView()
        line.backgroundColor = .black
        line.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.addSubview(line)
        
        line.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    private func addSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints {
            $0.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
}

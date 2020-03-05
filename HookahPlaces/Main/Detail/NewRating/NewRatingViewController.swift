//
//  NewRatingViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 01/12/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class NewRatingViewController: UIViewController {
    var presenter: NewRatingPresenterProtocol!
    
    private let hookahRatingView = NewRatingView(title: "Кальян")
    private let staffRatingView = NewRatingView(title: "Персонал")
    private let placeRatingView = NewRatingView(title: "Заведение")
    private let addRatingButton = PrimaryButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc
    private func didTapOnAddNewRating() {
        presenter.sendRating(onSuccess: { [weak self] in
            self?.showAlert(title: "Успешно!", description: "Благодарим за поставленную оценку!", completion: {
                self?.dismiss(animated: true, completion: nil)
            })
        }, onError: { [weak self] error in
            self?.showAlert(title: "Ошибка!", description: error)
        })
    }
}

extension NewRatingViewController {
    private func configureView() {
        title = "Новая оценка"
        view.backgroundColor = .white
        addCancelBarButtonItem()
        addHookahRating()
        addStaffRating()
        addPlaceRating()
        addNewRatingButton()
    }
    
    private func addHookahRating() {
        hookahRatingView.didSelectRating = { [weak self] newRating in
            self?.presenter.hookahRating = newRating
            print("Hookah rating: \(newRating)")
        }
        hookahRatingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hookahRatingView)
        
        hookahRatingView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
    
    private func addStaffRating() {
        staffRatingView.didSelectRating = { [weak self] newRating in
            self?.presenter.staffRating = newRating
            print("Staff rating: \(newRating)")
        }
        staffRatingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(staffRatingView)
        
        staffRatingView.snp.makeConstraints {
            $0.top.equalTo(hookahRatingView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
    }
    
    private func addPlaceRating() {
        placeRatingView.didSelectRating = { [weak self] newRating in
            self?.presenter.placeRating = newRating
            print("Place rating: \(newRating)")
        }
        placeRatingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(placeRatingView)
        
        placeRatingView.snp.makeConstraints {
            $0.top.equalTo(staffRatingView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
    }
    
    private func addNewRatingButton() {
        addRatingButton.setTitle("Оценить", for: .normal)
        addRatingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addRatingButton)
        
        addRatingButton.snp.makeConstraints {
            $0.top.equalTo(placeRatingView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        addRatingButton.addTarget(self, action: #selector(didTapOnAddNewRating), for: .touchUpInside)
    }
}

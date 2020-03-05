//
//  DetailPlaceCoordinator.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 09.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

protocol DetailPlaceCoordinatorProtocol {
    func openMap(place: Place)
    func openNewRating(for placeId: Int)
    func openCall(to phone: String)
    func openUsersInPlace()
}

final class DetailPlaceCoordinator: DetailPlaceCoordinatorProtocol {
    weak var view: DetailPlaceViewController?
    
    init(view: DetailPlaceViewController) {
        self.view = view
    }
    
    func openMap(place: Place) {
        let controller = MapViewController()
        controller.presenter = MapPresenter(view: controller, selectedPlace: place)
        view?.presentRoot(controller)
    }
    
    func openNewRating(for placeId: Int) {
        let viewController = NewRatingViewController()
        viewController.presenter = NewRatingPresenter(view: viewController, placeId: placeId)
        view?.presentRoot(viewController)
    }
    
    func openCall(to phone: String) {
        guard let url = URL(string: "tel://\(phone)") else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func openUsersInPlace() {
        view?.navigationController?.pushViewController(UsersViewController(), animated: true)
    }
}

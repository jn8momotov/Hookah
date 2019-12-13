//
//  MapCoordinator.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 10.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit
import CoreLocation

protocol MapCoordinator {
    func openRouteActionSheet(from fromLocation: CLLocationCoordinate2D?, to toLocation: CLLocationCoordinate2D)
    func openDetail(_ place: Place)
    func openCall(to phone: String)
    func dismiss()
}

final class MapCoordinatorImpl: MapCoordinator {
    weak var view: MapViewController?
    
    init(view: MapViewController) {
        self.view = view
    }
    
    func openRouteActionSheet(from fromLocation: CLLocationCoordinate2D?, to toLocation: CLLocationCoordinate2D) {
        let alert = UIAlertController(title: "Построить маршрут", message: nil, preferredStyle: .actionSheet)
        let yandexMapAction = UIAlertAction(title: "Яндекс.Карты", style: .default) { [weak self] _ in
            self?.openYandexMap(from: fromLocation!, to: toLocation)
        }
        let yandexNaviAction = UIAlertAction(title: "Яндекс.Навигатор", style: .default) { [weak self] _ in
            self?.openYandexNavigator(to: toLocation)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        if let _ = fromLocation {
            alert.addAction(yandexMapAction)
        }
        alert.addAction(yandexNaviAction)
        alert.addAction(cancelAction)
        view?.presentFull(alert)
    }
    
    func openDetail(_ place: Place) {
        let controller = DetailPlaceViewController()
        controller.presenter = DetailPlacePresenter(view: controller, place: place)
        view?.push(controller)
    }
    
    func openCall(to phone: String) {
        guard let url = URL(string: "tel://\(phone)") else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
}

extension MapCoordinatorImpl {
    private func openYandexMap(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        let header = "yandexmaps://maps.yandex.ru/?"
        let appURL = header + "rtext=\(from.latitude),\(from.longitude)~\(to.latitude),\(to.longitude)&rtt=mt"
        let appStoreURL = "https://itunes.apple.com/ru/app/id313877526"
        openApp(appURL: appURL, appStoreURL: appStoreURL)
    }
    
    private func openYandexNavigator(to: CLLocationCoordinate2D) {
        let appURL = "yandexnavi://build_route_on_map?lat_to=\(to.latitude)&lon_to=\(to.longitude)"
        let appStoreURL = "https://itunes.apple.com/ru/app/id474500851"
        openApp(appURL: appURL, appStoreURL: appStoreURL)
    }
    
    private func openApp(appURL stringURL: String, appStoreURL stringAppStoreURL: String) {
        guard let appURL = URL(string: stringURL), let appStoreURL = URL(string: stringAppStoreURL) else {
            return
        }
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        }
    }
}

//
//  MapCoordinator.swift
//  HookahPlaces
//
//  Created by Момотов Евгений Олегович on 10.12.2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

protocol MapCoordinatorProtocol {
    func openRouteActionSheet(to location: LocationPlace)
    func openDetail(_ place: Place)
    func openCall(to phone: String)
    func dismiss()
}

final class MapCoordinator: MapCoordinatorProtocol {
    weak var view: MapViewController?
    
    init(view: MapViewController) {
        self.view = view
    }
    
    func openRouteActionSheet(to location: LocationPlace) {
        let alert = UIAlertController(title: "Построить маршрут", message: nil, preferredStyle: .actionSheet)
        let yandexMapAction = UIAlertAction(title: "Яндекс.Карты", style: .default) { [weak self] _ in
            self?.openYandexMap()
        }
        let yandexNaviAction = UIAlertAction(title: "Яндекс.Навигатор", style: .default) { [weak self] _ in
            self?.openYandexNavigator()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(yandexMapAction)
        alert.addAction(yandexNaviAction)
        alert.addAction(cancelAction)
        view?.presentFull(alert)
    }
    
    func openDetail(_ place: Place) {
        
    }
    
    func openCall(to phone: String) {
        
    }
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
}

extension MapCoordinator {
    private func openYandexMap(to location: LocationPlace) {
        //let urlString = "yandexnavi://build_route_on_map?lat_to=\(location.latitude)&lon_to=\(location.longitude)"
        let urlString = "yandexmaps://maps.yandex.ru/?rtext=59.967870,30.242658~59.898495,30.299559&rtt=mt"
        guard let url = URL(string: urlString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let urlAppStore = "https://itunes.apple.com/ru/app/yandeks.navigator/id474500851?mt=8"
            openURL(urlAppStore)
        }
    }
    
    private func openYandexNavigator() {
        
    }
    
    private func openURL(_ stringURL: String) {
        guard let url = URL(string: stringURL) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

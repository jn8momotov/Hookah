//
//  LocationService.swift
//  HookahPlaces
//
//  Created by Евгений on 26/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    var accessToUserLocation: Bool { get }
    var didUpdateLocation: (() -> Void)? { get set }
    func startUpdateLocation()
    func distance(to place: Place) -> Float
}

final class LocationService: NSObject, LocationServiceProtocol {
    private let locationManager = CLLocationManager()
    
    private var currentLocation: CLLocation? {
        didSet {
            didUpdateLocation?()
        }
    }
    
    var accessToUserLocation: Bool {
        return CLLocationManager.authorizationStatus() != .restricted
    }
    
    var didUpdateLocation: (() -> Void)?
    
    func startUpdateLocation() {
        locationManager.requestWhenInUseAuthorization()
        guard CLLocationManager.authorizationStatus() != .restricted else {
            return
        }
        locationManager.delegate = self
        locationManager.activityType = .other
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func distance(to place: Place) -> Float {
        guard let currentLocation = currentLocation, let location = place.location else {
            return 0.0
        }
        let placeLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let distance = currentLocation.distance(from: placeLocation)
        let distanceKm = Float(distance / 1000)
        return Float(round(10 * distanceKm) / 10)
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        currentLocation = location
        locationManager.stopUpdatingLocation()
    }
}


//
//  MapViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 26/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    private var presenter: MapPresenterProtocol!
    private let locationManager = CLLocationManager()
    
    private let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MapPresenter(view: self)
        configureView()
        configureLocationManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupRegionOnUser()
    }
    
    @objc
    private func didTapOnCloseBarButtonItem() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupRegionOnUser() {
        let location = mapView.userLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController {
    private func configureView() {
        title = "Map"
        addCloseBarButtonItem()
        addMapView()
    }
    
    private func configureLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }
    
    private func addMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addPlacesAnnotations()
    }
    
    private func addPlacesAnnotations() {
        presenter.places.forEach({ addAnnotation($0) })
    }
    
    private func addAnnotation(_ place: Place) {
        let location = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = place.name
        annotation.subtitle = place.metro
        mapView.addAnnotation(annotation)
    }
    
    private func addCloseBarButtonItem() {
        let closeBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "close"),
            style: .plain,
            target: self,
            action: #selector(didTapOnCloseBarButtonItem)
        )
        closeBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }
}

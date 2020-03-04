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
    var presenter: MapPresenterProtocol!
    
    private let mapView = MKMapView()
    private let placeView = MapPlaceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setStartRegion()
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        let radius: CLLocationDistance = 2_000
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
    }
    
    private func setStartRegion() {
        if let selectedPlace = presenter.selectedPlace {
            let coordinate = CLLocationCoordinate2D(latitude: selectedPlace.latitude, longitude: selectedPlace.longitude)
            setRegion(coordinate)
            return
        }
        let coordinate = presenter.accessToUserLocation
            ? mapView.userLocation.coordinate
            : CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)
        setRegion(coordinate)
    }
    
    private func updatePlaceView() {
        if let place = presenter.selectedPlace {
            placeView.set(place)
            placeView.isHidden = false
        } else {
            placeView.isHidden = true
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let point = view.annotation as? PlacePointAnnotation {
            presenter.selectedPlace = presenter.places[point.identifier]
            updatePlaceView()
            setRegion(point.coordinate)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        presenter.selectedPlace = nil
        updatePlaceView()
    }
}

extension MapViewController {
    private func configureView() {
        title = "Карта"
        addCancelBarButtonItem()
        addMapView()
        addPlaceView()
        addTargets()
        setBackBarButtonItem()
    }
    
    private func addPlaceView() {
        placeView.isHidden = true
        placeView.layer.cornerRadius = 8
        placeView.layer.shadowRadius = 6.0
        placeView.layer.shadowOpacity = 0.6
        placeView.layer.shadowOffset = .zero
        placeView.layer.shadowColor = UIColor.black.cgColor
        placeView.clipsToBounds = false
        placeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(placeView)
        
        placeView.snp.makeConstraints {
            $0.left.bottom.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(132)
        }
        
        updatePlaceView()
        selectSelectedPlaceAnnotation()
    }
    
    private func selectSelectedPlaceAnnotation() {
        guard let place = presenter.selectedPlace, let index = presenter.places.firstIndex(of: place) else {
            return
        }
        for point in mapView.annotations as? [PlacePointAnnotation] ?? [] {
            if point.identifier == index {
                mapView.selectAnnotation(point, animated: true)
                return
            }
        }
    }
    
    private func addTargets() {
        placeView.didTapDetail = { [weak self] in
            self?.presenter.openDetail()
        }
        placeView.didTapRoute = { [weak self] in
            self?.presenter.openRoute()
        }
        placeView.didTapCall = { [weak self] in
            self?.presenter.openCall()
        }
    }
    
    private func addMapView() {
        mapView.delegate = self
        mapView.userLocation.title = nil
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addPlacesAnnotations()
    }
    
    private func addPlacesAnnotations() {
        for (index, place) in presenter.places.enumerated() {
            addAnnotation(place, id: index)
        }
    }
    
    private func addAnnotation(_ place: Place, id: Int) {
        let location = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let annotation = PlacePointAnnotation(identifier: id)
        annotation.coordinate = location
        annotation.title = place.name
        annotation.subtitle = place.metro
        mapView.addAnnotation(annotation)
    }
}

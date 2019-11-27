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
    
    private let mapView = MKMapView()
    private let placeView = MapPlaceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MapPresenter(view: self)
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setStartRegion()
    }
    
    @objc
    private func didTapOnCloseBarButtonItem() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        let radius: CLLocationDistance = 2_000
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
    }
    
    private func setStartRegion() {
        let coordinate = presenter.accessToUserLocation
            ? mapView.userLocation.coordinate
            : CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)
        setRegion(coordinate)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let point = view.annotation as? PlacePointAnnotation {
            placeView.set(presenter.places[point.identifier])
            setRegion(point.coordinate)
            placeView.isHidden = false
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        placeView.isHidden = true
    }
}

extension MapViewController {
    private func configureView() {
        title = "Map"
        addCloseBarButtonItem()
        addMapView()
        addPlaceView()
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

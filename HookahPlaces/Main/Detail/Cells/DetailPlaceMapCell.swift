//
//  DetailPlaceMapCell.swift
//  HookahPlaces
//
//  Created by Евгений on 29/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit
import MapKit

final class DetailPlaceMapCell: UITableViewCell, DetailPlaceCellProtocol {
    static let identifier = String(describing: DetailPlaceMapCell.self)
    
    private let mapView = MKMapView()
    
    private var pointPlace: PlacePointAnnotation?
    private var viewModel: DetailPlaceMapViewModel? {
        didSet {
            updateView()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: DetailPlaceMapCell.identifier)
        configureViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ viewModel: DetailPlaceCellViewModelProtocol) {
        self.viewModel = viewModel as? DetailPlaceMapViewModel
    }
    
    private func updateView() {
        guard let viewModel = viewModel, pointPlace == nil else {
            return
        }
        let location = CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        pointPlace = PlacePointAnnotation(identifier: 0)
        pointPlace?.coordinate = location
        pointPlace?.title = viewModel.name
        mapView.addAnnotation(pointPlace!)
        mapView.setRegion(region, animated: false)
    }
    
    @objc
    private func didTapOnMap() {
        viewModel?.didTapMap?()
    }
}

extension DetailPlaceMapCell {
    private func configureViewCell() {
        backgroundColor = .white
        selectionStyle = .none
        addMapView()
    }
    
    private func addMapView() {
        mapView.layer.cornerRadius = 8
        mapView.clipsToBounds = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapView)
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
            $0.height.equalTo(120)
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnMap))
        mapView.addGestureRecognizer(gesture)
    }
}

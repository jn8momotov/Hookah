//
//  PlacesService.swift
//  HookahPlaces
//
//  Created by Евгений on 19/02/2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

protocol PlacesService {
    func loadAll(completion: VoidHandler?)
}

final class PlacesServiceImpl: PlacesService {
    private let databaseRef = Database.database().reference(withPath: "places")
    private let storageRef = Storage.storage().reference()
    
    func loadAll(completion: VoidHandler?) {
        databaseRef.observe(.value) { [weak self] snapshot in
            for item in snapshot.children {
                guard let snapshotPlace = item as? DataSnapshot else {
                    continue
                }
                let place = Place()
                place.set(snapshot: snapshotPlace)
                RealmService.shared.save(place)
                self?.loadImage(for: place, completion: completion)
            }
        }
    }
}

extension PlacesServiceImpl {
    private func loadImage(for place: Place, completion: VoidHandler?) {
        let id = place.firebaseID
        storageRef.child("places/\(id).jpg").getData(maxSize: 1 * 1024 * 1024) { data, error in
            guard let data = data else {
                completion?()
                return
            }
            RealmService.shared.edit {
                place.image = data
            }
            completion?()
        }
    }
}

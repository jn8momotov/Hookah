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
    func load(completion: VoidHandler?)
    func sendRating(_ rating: RatingPlace,
                    for placeId: Int,
                    from userId: String,
                    onSuccess: VoidHandler?,
                    onError: ErrorHandler?)
}

final class PlacesServiceImpl: PlacesService {
    private let databaseRef = Database.database().reference()
    private let storageRef = Storage.storage().reference()
    
    func load(completion: VoidHandler?) {
        loadVersionDatabase { [weak self] versionDB in
            guard let versionDB = versionDB else {
                completion?()
                return
            }
            self?.updatePlaces(versionDB: versionDB, completion: {
                UserDefaults.standard.versionDB = versionDB
                completion?()
            })
        }
    }
    
    func sendRating(_ rating: RatingPlace,
                    for placeId: Int,
                    from userId: String,
                    onSuccess: VoidHandler?,
                    onError: ErrorHandler?) {
        let value = [
            "ratingHookah": rating.hookah,
            "ratingPlace": rating.place,
            "ratingStaff": rating.staff
        ]
        databaseRef.child("places").child("\(placeId)").child("assessments").child(userId).setValue(value) { error, _ in
            if let error = error {
                onError?(error.localizedDescription)
                return
            }
            onSuccess?()
        }
    }
}

extension PlacesServiceImpl {
    private func loadVersionDatabase(completion: @escaping (String?) -> Void) {
        databaseRef.child("version").observeSingleEvent(of: .value) { snapshot in
            completion(snapshot.value as? String)
        }
    }
    
    private func updatePlaces(versionDB: String, completion: VoidHandler?) {
        let currentDB = UserDefaults.standard.versionDB ?? ""
        let currentPaths = currentDB.split(separator: ".").compactMap({ Int($0) })
        let paths = versionDB.split(separator: ".").compactMap({ Int($0) })
        guard paths.count == 3, currentPaths.count == 3 else {
            loadAll(completion: completion)
            return
        }
        if paths[0] != currentPaths[0] {
            loadAll(completion: completion)
            return
        }
        if paths[1] != currentPaths[1] || paths[2] != currentPaths[2] {
            loadAll(loadingImages: false, completion: completion)
            return
        }
    }
    
    private func loadAll(loadingImages: Bool = true, completion: VoidHandler?) {
        loadPlaceDataSnapshot { [weak self] dictionary in
            let place = Place()
            place.set(dictionary: dictionary)
            RealmService.shared.save(place)
            loadingImages ? self?.loadImage(for: place, completion: completion) : completion?()
        }
    }
    
    private func loadPlaceDataSnapshot(completion: @escaping ([String: Any]) -> Void) {
        databaseRef.child("places").observeSingleEvent(of: .value) { snapshot in
            guard let values = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            values.forEach({
                if let value = $0.value as? [String: Any] {
                    completion(value)
                }
            })
        }
    }
    
    private func loadImage(for place: Place, completion: VoidHandler?) {
        let id = place.id
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

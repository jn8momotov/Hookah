//
//  RealmService.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    func get<T: Object>(_ type: T.Type) -> [T]
    func get<T: Object>(_ type: T.Type, predicate: NSPredicate) -> [T]
    func getResults<T: Object>(_ type: T.Type, predicate: NSPredicate) -> Results<T>
    func edit(_ handler: @escaping () -> Void)
    func save(_ object: Object)
    func delete(_ object: Object)
    func deleteAll<T: Object>(_ type: T.Type)
}

final class RealmService: RealmServiceProtocol {
    static let shared: RealmServiceProtocol = RealmService()
    
    private init() {
        print("Realm url: \(String(describing: realm.configuration.fileURL))")
    }
    
    private let realm = try! Realm()
    
    func get<T: Object>(_ type: T.Type) -> [T] {
        return realm.objects(type).compactMap({ $0 })
    }
    
    func get<T: Object>(_ type: T.Type, predicate: NSPredicate) -> [T] {
        return realm.objects(type).filter(predicate).compactMap({ $0 })
    }
    
    func getResults<T: Object>(_ type: T.Type, predicate: NSPredicate) -> Results<T> {
        return realm.objects(type).filter(predicate)
    }
    
    func edit(_ handler: @escaping () -> Void) {
        try? realm.write {
            handler()
        }
    }
    
    func save(_ object: Object) {
        try? realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func delete(_ object: Object) {
        try? realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll<T: Object>(_ type: T.Type) {
        try? realm.write {
            realm.delete(realm.objects(type))
        }
    }
}

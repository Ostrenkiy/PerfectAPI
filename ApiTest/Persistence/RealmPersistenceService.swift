//
//  RealmPersistenceService.swift
//  ApiTest
//
//  Created by Ostrenkiy on 28.09.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//


import Foundation
import RealmSwift
import PromiseKit

class RealmPersistenceService {
    
    private let currentSchemaVersion: UInt64 = 0
    
    private var realm: Realm?
    
    static let shared = RealmPersistenceService()
    
    private init() {}
    
    func setup() {
        let config = Realm.Configuration(
            schemaVersion: self.currentSchemaVersion,
            migrationBlock: { _, _ in
            // potentially lengthy data migration
            }
        )
        self.realm = try? Realm(configuration: config)
    }
    
    func write<T: RealmObjectConvertable>(objects: [T]) {
        try? self.realm?.write {
            for object in objects {
                self.realm?.create(T.RealmObjectType.self, value: object.realmObject, update: true)
            }
        }
    }
    
    
    func write<T: RealmObjectConvertable>(object: T) {
        self.write(objects: [object])
    }
    
    func read<T: RealmObjectConvertable>(type: T.Type, predicate: NSPredicate?) -> [T] {
        var res = self.realm?.objects(T.RealmObjectType.self)
        if let predicate = predicate {
            res = res?.filter(predicate)
        }
        guard let results = res?.map({
            T(realmObject: $0)
        }) else {
            return []
        }
        return Array(results)
    }
}

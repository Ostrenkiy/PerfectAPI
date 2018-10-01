//
//  CoursePersistent.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation
import RealmSwift

class CoursePersistent: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
}

extension Course: RealmObjectConvertable {
    typealias RealmObjectType = CoursePersistent
    
    convenience init(realmObject: RealmObjectType) {
        self.init(
            id: realmObject.id,
            title: realmObject.title
        )
    }
    
    var realmObject: RealmObjectType {
        return CoursePersistent(plainObject: self)
    }
}

extension CoursePersistent {
    convenience init(plainObject: Course) {
        self.init()
        self.id = plainObject.id
        self.title = plainObject.title
    }
}

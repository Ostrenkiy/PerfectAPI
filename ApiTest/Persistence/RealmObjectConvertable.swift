//
//  RealmObjectConvertable.swift
//  ApiTest
//
//  Created by Ostrenkiy on 28.09.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//


import Foundation
import RealmSwift

protocol RealmObjectConvertable {
    associatedtype RealmObjectType: Object
    init(realmObject: RealmObjectType)
    var realmObject: RealmObjectType { get }
}

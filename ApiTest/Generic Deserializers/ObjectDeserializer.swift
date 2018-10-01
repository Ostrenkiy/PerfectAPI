//
//  ObjectDeserializer.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation

protocol ObjectDeserializer {
    associatedtype ObjectType
    associatedtype SerializedType: DataDeserializable
    
    func deserialize(serialized: SerializedType) -> ObjectType?
}

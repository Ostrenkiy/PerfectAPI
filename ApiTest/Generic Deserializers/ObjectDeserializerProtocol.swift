//
//  ObjectDeserializerProtocol.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation

protocol ObjectDeserializerProtocol {
    associatedtype ObjectType
    associatedtype SerializedType: DataDeserializableProtocol
    
    func deserialize(serialized: SerializedType) -> ObjectType?
}

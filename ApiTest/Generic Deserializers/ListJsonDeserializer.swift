//
//  ListJsonDeserializer.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListJsonDeserializer<T: ObjectDeserializerProtocol>: ObjectDeserializerProtocol where T.SerializedType == JSON {
    var objectJsonDeserializer: T
    
    init(objectJsonDeserializer: T) {
        self.objectJsonDeserializer = objectJsonDeserializer
    }
    
    func deserialize(serialized: JSON) -> [T.ObjectType]? {
        guard let jsonArray = serialized.array else {
            return nil
        }
        
        var res: [T.ObjectType] = []
        for jsonObject in jsonArray {
            if let deserializedObject = objectJsonDeserializer.deserialize(serialized: jsonObject) {
                res += [deserializedObject]
            } else {
                return nil
            }
        }
        return res
    }
}

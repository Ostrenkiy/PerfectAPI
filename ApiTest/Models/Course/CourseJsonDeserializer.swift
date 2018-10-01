//
//  CourseJsonDeserializer.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

class CourseJsonDeserializer: ObjectJsonDeserializerProtocol {
    func deserialize(serialized: JSON) -> Course? {
        if let id = serialized["id"].int,
           let title = serialized["title"].string {
            return Course(id: id, title: title)
        } else {
            return nil
        }
    }
}

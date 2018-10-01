//
//  MetaJsonDeserializer.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

class MetaJsonDeserializer: ObjectDeserializerProtocol {
    func deserialize(serialized: JSON) -> Meta? {
        if let hasNext = serialized["has_next"].bool,
            let hasPrev = serialized["has_previous"].bool,
            let page = serialized["page"].int {
            return Meta(hasNext: hasNext, hasPrev: hasPrev, page: page)
        } else {
            return nil
        }
    }
}

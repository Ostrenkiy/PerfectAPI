//
//  DataDeserializable.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol DataDeserializable {
    init(serializedData: Data)
}

extension JSON: DataDeserializable {
    init(serializedData: Data) {
        self.init(data: serializedData)
    }
}

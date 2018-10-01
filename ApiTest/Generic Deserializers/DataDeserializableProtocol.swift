//
//  DataDeserializableProtocol.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol DataDeserializableProtocol {
    init(serializedData: Data)
}

extension JSON: DataDeserializableProtocol {
    init(serializedData: Data) {
        self.init(data: serializedData)
    }
}

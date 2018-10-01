//
//  ApiEndpoint.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation

class ApiEndpoint {
    var requestMaker: RequestMaker
    
    init(requestMaker: RequestMaker) {
        self.requestMaker = requestMaker
    }
}

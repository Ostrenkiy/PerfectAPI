//
//  Meta.swift
//  ApiTest
//
//  Created by Ostrenkiy on 29.09.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation

struct Meta {
    var hasNext: Bool
    var hasPrev: Bool
    var page: Int
    
    init(hasNext: Bool, hasPrev: Bool, page: Int) {
        self.hasNext = hasNext
        self.hasPrev = hasPrev
        self.page = page
    }
    
    static var oneAndOnlyPage: Meta {
        return Meta(hasNext: false, hasPrev: false, page: 1)
    }
}

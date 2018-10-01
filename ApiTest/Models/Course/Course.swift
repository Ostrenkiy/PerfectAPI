//
//  Course.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation

final class Course {
    var id: Int
    var title: String
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

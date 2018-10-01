//
//  CoursesResponseDeserializer.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

class CoursesResponseDeserializer: ObjectDeserializer {
    
    var metaJsonDeserializer: MetaJsonDeserializer
    var courseJsonDeserializer: CourseJsonDeserializer
    
    init(metaJsonDeserializer: MetaJsonDeserializer, courseJsonDeserializer: CourseJsonDeserializer) {
        self.metaJsonDeserializer = metaJsonDeserializer
        self.courseJsonDeserializer = courseJsonDeserializer
    }
    
    func deserialize(serialized: JSON) -> ([Course], Meta)? {
        let coursesListDeserializer = ListJsonDeserializer(objectJsonDeserializer: courseJsonDeserializer)
        if let meta = metaJsonDeserializer.deserialize(serialized: serialized["meta"]),
            let courses = coursesListDeserializer.deserialize(serialized: serialized["courses"]) {
            return (courses, meta)
        } else {
            return nil
        }
    }
}

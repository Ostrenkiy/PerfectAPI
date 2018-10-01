//
//  CoursesApi.swift
//  ApiTest
//
//  Created by Ostrenkiy on 01.10.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class CoursesApi: ApiEndpoint {
    func getCourses() -> Promise<([Course], Meta)> {
        let path = "https://stepik.org/api/courses"
        let params: [String: Any] = ["is_featured": "true"]
        let responseDeserializer = CoursesResponseDeserializer(metaJsonDeserializer: MetaJsonDeserializer(), courseJsonDeserializer: CourseJsonDeserializer())
        
        return requestMaker.request(path: path, method: .get, params: params, encoding: URLEncoding.default, headers: [:], responseDeserializer: responseDeserializer)
    }
}

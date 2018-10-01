//
//  RetrieveRequestMaker.swift
//  ApiTest
//
//  Created by Ostrenkiy on 28.09.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit
import Alamofire

protocol DataDeserializable {
    init(serializedData: Data)
}

protocol ObjectDeserializer {
    associatedtype ObjectType
    associatedtype SerializedType: DataDeserializable
    
    func deserialize(serialized: SerializedType) -> ObjectType?
}

extension JSON: DataDeserializable {
    init(serializedData: Data) {
        self.init(data: serializedData)
    }
}

class RequestMaker {
    //TODO: Setup adapter and retrier when initializing this object
    private let manager: Alamofire.SessionManager
    
    init() {
        manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default
        )
    }
    
    func request<T: ObjectDeserializer>(
        path: String,
        method: HTTPMethod,
        params: Parameters,
        encoding: ParameterEncoding,
        headers: [String: String],
        responseDeserializer: T
    ) -> Promise<T.ObjectType> {
        return Promise<T.ObjectType> { seal in
            manager.request(
                path,
                method: method,
                parameters: params,
                encoding: encoding,
                headers: headers
            ).validate().responseData { response in
                switch response.result {
                case .failure(let error):
                    seal.reject(error)
                case .success(let data):
                    if let deserializedObject = responseDeserializer.deserialize(serialized: T.SerializedType(serializedData: data)) {
                        seal.fulfill(deserializedObject)
                    } else {
                        seal.reject(DeserializationError.error)
                    }
                }
            }
        }
    }
}

enum DeserializationError: Error {
    case error
}

class Course {
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
}

class CourseJsonDeserializer: ObjectDeserializer {
    func deserialize(serialized: JSON) -> Course? {
        if let id = serialized["id"].int {
            return Course(id: id)
        } else {
            return nil
        }
    }
}

class MetaJsonDeserializer: ObjectDeserializer {
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

class ListJSONDeserializer<T: ObjectDeserializer>: ObjectDeserializer where T.SerializedType == JSON {
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

class CoursesResponseDeserializer: ObjectDeserializer {
    
    var metaJsonDeserializer: MetaJsonDeserializer
    var courseJsonDeserializer: CourseJsonDeserializer
    
    init(metaJsonDeserializer: MetaJsonDeserializer, courseJsonDeserializer: CourseJsonDeserializer) {
        self.metaJsonDeserializer = metaJsonDeserializer
        self.courseJsonDeserializer = courseJsonDeserializer
    }
    
    func deserialize(serialized: JSON) -> ([Course], Meta)? {
        let coursesListDeserializer = ListJSONDeserializer(objectJsonDeserializer: courseJsonDeserializer)
        if let meta = metaJsonDeserializer.deserialize(serialized: serialized["meta"]),
           let courses = coursesListDeserializer.deserialize(serialized: serialized["courses"]) {
            return (courses, meta)
        } else {
            return nil
        }
    }
}

class ApiEndpoint {
    var requestMaker: RequestMaker
    
    init(requestMaker: RequestMaker) {
        self.requestMaker = requestMaker
    }
}

class CoursesApi: ApiEndpoint {
    func getCourses() -> Promise<([Course], Meta)> {
        let path = "https://stepik.org/api/courses"
        let params: Parameters = ["is_featured": "true"]
        let responseDeserializer = CoursesResponseDeserializer(metaJsonDeserializer: MetaJsonDeserializer(), courseJsonDeserializer: CourseJsonDeserializer())
        
        return requestMaker.request(path: path, method: .get, params: params, encoding: URLEncoding.default, headers: [:], responseDeserializer: responseDeserializer)
    }
}

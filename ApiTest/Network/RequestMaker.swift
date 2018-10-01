//
//  RequestMaker.swift
//  ApiTest
//
//  Created by Ostrenkiy on 28.09.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit
import Alamofire

class RequestMaker {
    //TODO: Setup adapter and retrier when initializing this object
    private let manager: Alamofire.SessionManager
    
    init() {
        manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default
        )
    }
    
    func request<T: ObjectDeserializerProtocol>(
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

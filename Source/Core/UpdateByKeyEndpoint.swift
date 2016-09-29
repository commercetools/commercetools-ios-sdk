//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    All endpoints capable of being updated by key should conform to this protocol.

    Default implementation provides update by key capability for all Commercetools endpoints which do support it.
*/
public protocol UpdateByKeyEndpoint: Endpoint {

    /**
        Updates an object by UUID at the endpoint specified with `path` value.

        - parameter key:                      The key value used to reference resource to be updated.
        - parameter version:                  Version of the object (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    static func updateByKey(_ key: String, version: UInt, actions: [[String: Any]], expansion: [String]?, result: @escaping (Result<ResponseType>) -> Void)
    
    /**
        Updates an object by UUID at the endpoint specified with `path` value.

        - parameter key:                      The key value used to reference resource to be updated.
        - parameter version:                  Version of the object (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter expansion:                An optional array of expansion property names.
        - parameter dictionaryResult:         The code to be executed after processing the response, containing result
                                              in dictionary format in case of a success.
     */
    static func updateByKey(_ key: String, version: UInt, actions: [[String: Any]], expansion: [String]?, dictionaryResult: @escaping (Result<[String: Any]>) -> Void)

}

public extension UpdateByKeyEndpoint {
    
    static func updateByKey(_ key: String, version: UInt, actions: [[String: Any]], expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        updateByKey(key, version: version, actions: actions, expansion: expansion, result: result, completionHandler: { response in
            handleResponse(response, result: result)
        })
    }
    
    static func updateByKey(_ key: String, version: UInt, actions: [[String: Any]], expansion: [String]? = nil, dictionaryResult: @escaping (Result<[String: Any]>) -> Void) {
        updateByKey(key, version: version, actions: actions, expansion: expansion, result: dictionaryResult, completionHandler: { response in
            handleResponse(response, result: dictionaryResult)
        })
    }
    
    private static func updateByKey<T>(_ key: String, version: UInt, actions: [[String: Any]], expansion: [String]? = nil, result: @escaping (Result<T>) -> Void,
                               completionHandler: @escaping (DataResponse<Any>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion("\(path)key=\(key)", expansion: expansion)
            
            Alamofire.request(fullPath, method: .post, parameters: ["version": version, "actions": actions], encoding: JSONEncoding.default, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: completionHandler)
        })
    }
}

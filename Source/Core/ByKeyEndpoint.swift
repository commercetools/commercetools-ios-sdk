//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    All endpoints capable of being retrieved by key should conform to this protocol.

    Default implementation provides retrieval by key capability for all Commercetools endpoints which do support it.
*/
public protocol ByKeyEndpoint: Endpoint {

    /**
        Retrieves an object by UUID at the endpoint specified with `path` value.

        - parameter key:                      The key value used retrieve resource.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    static func byKey(_ key: String, expansion: [String]?, result: @escaping (Result<ResponseType>) -> Void)
    
    /**
        Retrieves an object by UUID at the endpoint specified with `path` value.

        - parameter key:                      The key value used retrieve resource.
        - parameter expansion:                An optional array of expansion property names.
        - parameter dictionaryResult:         The code to be executed after processing the response, containing result
                                              in dictionary format in case of a success.
     */
    static func byKey(_ key: String, expansion: [String]?, dictionaryResult: @escaping (Result<[String: Any]>) -> Void)

}

public extension ByKeyEndpoint {
    
    static func byKey(_ key: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        byKey(key, expansion: expansion, result: result, completionHandler: { response in
            handleResponse(response, result: result)
        })
    }
    
    static func byKey(_ key: String, expansion: [String]? = nil, dictionaryResult: @escaping (Result<[String: Any]>) -> Void) {
        byKey(key, expansion: expansion, result: dictionaryResult, completionHandler: { response in
            handleResponse(response, result: dictionaryResult)
        })
    }
    
    private static func byKey<T>(_ key: String, expansion: [String]? = nil, result: @escaping (Result<T>) -> Void, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion("\(path)key=\(key)", expansion: expansion)
            
            Alamofire.request(fullPath, parameters: nil, encoding: JSONEncoding.default, headers: self.headers(token))
                .responseJSON(queue: DispatchQueue.global(), completionHandler: completionHandler)
        })
    }
}

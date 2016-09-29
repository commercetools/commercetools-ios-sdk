//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

/**
    All endpoints capable of creating new objects should conform to this protocol.

    Default implementation provides creating capability for most of the Commercetools endpoints
    which do support it.
*/
public protocol CreateEndpoint: Endpoint {

    /**
        Creates new object at the endpoint specified with `path` value.

        - parameter object:                   Dictionary representation of the draft object to be created.
        - parameter expansion:                An optional array of expansion property names.
     - parameter result:                      The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    static func create(_ object: [String: Any], expansion: [String]?, result: @escaping (Result<ResponseType>) -> Void)
    
    /**
     Creates new object at the endpoint specified with `path` value.
     
     - parameter object:                   Dictionary representation of the draft object to be created.
     - parameter expansion:                An optional array of expansion property names.
     - parameter dictionaryResult:         The code to be executed after processing the response, containing result
                                           in dictionary format in case of a success.
     */
    static func create(_ object: [String: Any], expansion: [String]?, dictionaryResult: @escaping (Result<[String: Any]>) -> Void)

}

public extension CreateEndpoint {

    static func create(_ object: [String: Any], expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        create(object, expansion: expansion, result: result, completionHandler: { response in
            handleResponse(response, result: result)
        })
    }
    
    static func create(_ object: [String: Any], expansion: [String]? = nil, dictionaryResult: @escaping (Result<[String: Any]>) -> Void) {
        create(object, expansion: expansion, result: dictionaryResult, completionHandler: { response in
            handleResponse(response, result: dictionaryResult)
        })
    }
    
    private static func create<T>(_ object: [String: Any], expansion: [String]? = nil, result: @escaping (Result<T>) -> Void, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)
            
            Alamofire.request(fullPath, method: .post, parameters: object, encoding: JSONEncoding.default, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: completionHandler)
        })
    }
}

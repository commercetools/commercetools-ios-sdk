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
        - parameter result:                   The code to be executed after processing the response.
    */
    static func updateByKey(_ key: String, version: UInt, actions: [[String: Any]], expansion: [String]?, result: (Result<[String: AnyObject]>) -> Void)

}

public extension UpdateByKeyEndpoint {

    static func updateByKey(_ key: String, version: UInt, actions: [[String: Any]], expansion: [String]? = nil, result: @escaping (Result<[String: AnyObject]>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion("\(path)key=\(key)", expansion: expansion)

            Alamofire.request(fullPath, method: .post, parameters: ["version": version, "actions": actions], encoding: URLEncoding.httpBody, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                handleResponse(response, result: result)
            })
        })
    }
}

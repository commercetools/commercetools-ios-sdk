//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    All endpoints capable of being updated by UUID should conform to this protocol.

    Default implementation provides update by UUID capability for all Commercetools endpoints which do support it.
*/
public protocol UpdateEndpoint: Endpoint {

    /**
        Updates an object by UUID at the endpoint specified with `path` value.

        - parameter id:                       Unique ID of the object to be deleted.
        - parameter version:                  Version of the object (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func update(_ id: String, version: UInt, actions: [[String: Any]], expansion: [String]?, result: @escaping (Result<[String: Any]>) -> Void)

}

public extension UpdateEndpoint {

    static func update(_ id: String, version: UInt, actions: [[String: Any]], expansion: [String]? = nil, result: @escaping (Result<[String: Any]>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path + id, expansion: expansion)

            Alamofire.request(fullPath, method: .post, parameters: ["version": version, "actions": actions], encoding: JSONEncoding.default, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                handleResponse(response, result: result)
            })
        })
    }
}

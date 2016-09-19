//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    All endpoints capable of being retrieved by UUID should conform to this protocol.

    Default implementation provides retrieval by UUID capability for all Commercetools endpoints which do support it.
*/
public protocol ByIdEndpoint: Endpoint {

    /**
        Retrieves an object by UUID at the endpoint specified with `path` value.

        - parameter id:                       Unique ID of the object to be retrieved.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func byId(_ id: String, expansion: [String]?, result: @escaping (Result<[String: AnyObject]>) -> Void)

}

public extension ByIdEndpoint {

    static func byId(_ id: String, expansion: [String]? = nil, result: @escaping (Result<[String: AnyObject]>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path + id, expansion: expansion)

            Alamofire.request(fullPath, parameters: nil, encoding: URLEncoding.httpBody, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                handleResponse(response, result: result)
            })
        })
    }
}

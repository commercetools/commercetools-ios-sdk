//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

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
        - parameter result:                   The code to be executed after processing the response.
    */
    static func create(_ object: [String: Any], expansion: [String]?, result: @escaping (Result<[String: Any]>) -> Void)

}

public extension CreateEndpoint {

    static func create(_ object: [String: Any], expansion: [String]? = nil, result: @escaping (Result<[String: Any]>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)

            Alamofire.request(fullPath, method: .post, parameters: object, encoding: JSONEncoding.default, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                handleResponse(response, result: result)
            })
        })
    }
}

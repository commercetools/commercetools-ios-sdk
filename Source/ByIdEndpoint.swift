//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    All endpoints capable of being retrieved by UUID should conform to this protocol.

    Default implementation provides retrieval by UUID capability for all Commercetools endpoints which do support it.
*/
public protocol ByIdEndpoint: Endpoint {

    /**
        Retrieves an object by UUID at the endpoint specified with `path` value.

        - parameter id:                       Unique ID of the object to be retrieved.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    static func byId(_ id: String, expansion: [String]?, result: @escaping (Result<ResponseType>) -> Void)
}

public extension ByIdEndpoint {

    static func byId(_ id: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        byId(id, expansion: expansion, path: Self.path, result: result)
    }

    static func byId(_ id: String, expansion: [String]? = nil, path: String, result: @escaping (Result<ResponseType>) -> Void) {

        requestWithTokenAndPath(relativePath: path, result: result) { token, path in
            let fullPath = pathWithExpansion(path + id, expansion: expansion)
            let request = self.request(url: fullPath, headers: self.headers(token))

            perform(request: request) { (response: Result<ResponseType>) in
                result(response)
            }
        }
    }
}
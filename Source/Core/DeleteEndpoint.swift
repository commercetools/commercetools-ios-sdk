//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    All endpoints capable of being deleted by UUID should conform to this protocol.

    Default implementation provides deletion by UUID capability for all Commercetools endpoints which do support it.
*/
public protocol DeleteEndpoint: Endpoint {

    /**
        Deletes an object by UUID at the endpoint specified with `path` value.

        - parameter id:                       Unique ID of the object to be deleted.
        - parameter version:                  Version of the object (for optimistic concurrency control).
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    static func delete(_ id: String, version: UInt, expansion: [String]?, result: @escaping (Result<ResponseType>) -> Void)
}

public extension DeleteEndpoint {
    
    static func delete(_ id: String, version: UInt, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        
        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path + id, expansion: expansion)
            
            Alamofire.request(fullPath, method: .delete, parameters: ["version": version], encoding: URLEncoding.queryString, headers: self.headers(token))
                .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                    handleResponse(response, result: result)
                })
        })
    }
}

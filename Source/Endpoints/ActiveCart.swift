//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Alamofire
import ObjectMapper

/**
    Provides access to active cart endpoint.
*/
class ActiveCart: Endpoint {
    
    public typealias ResponseType = Cart

    static let path = "me/active-cart"

    /**
     Retrieves the cart with state Active which has the most recent lastModifiedAt.
     
     - parameter expansion:                An optional array of expansion property names.
     - parameter result:                   The code to be executed after processing the response.
     */
    static func get(expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        
        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)
            
            Alamofire.request(fullPath, parameters: nil, encoding: JSONEncoding.default, headers: self.headers(token))
                .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                    handleResponse(response, result: result)
                })
        })
    }
}

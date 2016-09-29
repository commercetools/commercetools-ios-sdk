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
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    static func get(expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        get(expansion: expansion, result: result, completionHandler: { response in
            handleResponse(response, result: result)
        })
    }

    /**
        Retrieves the cart with state Active which has the most recent lastModifiedAt.

        - parameter expansion:                An optional array of expansion property names.
        - parameter dictionaryResult:         The code to be executed after processing the response, containing result
                                              in dictionary format in case of a success.
    */
    static func get(expansion: [String]? = nil, dictionaryResult: @escaping (Result<[String: Any]>) -> Void) {
        get(expansion: expansion, result: dictionaryResult, completionHandler: { response in
            handleResponse(response, result: dictionaryResult)
        })
    }

    private static func get<T>(expansion: [String]? = nil, result: @escaping (Result<T>) -> Void, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)

            Alamofire.request(fullPath, parameters: nil, encoding: JSONEncoding.default, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: completionHandler)
        })
    }

}

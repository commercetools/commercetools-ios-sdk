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
        - parameter result:                   The code to be executed after processing the response. Either one of two
                                              optionals (response dictionary or an array) will have some value,
                                              depending on the request's success.
    */
    static func byId(id: String, expansion: [String]?, result: Result)

}

public extension ByIdEndpoint {

    static func byId(id: String, expansion: [String]? = nil, result: Result) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute byId command - check if the configuration is valid.")
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(nil, [error ?? Error.error(code: .GeneralCommercetoolsError)])
                return
            }

            let fullPath = pathWithExpansion(path + id, expansion: expansion)

            Alamofire.request(.GET, fullPath, parameters: nil, encoding: .JSON, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }
}
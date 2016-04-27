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
    static func create(object: [String: AnyObject], expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)

}

public extension CreateEndpoint {

    static func create(object: [String: AnyObject], expansion: [String]? = nil, result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute create command - check if the configuration is valid.")
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure([error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion(path, expansion: expansion)

            Alamofire.request(.POST, fullPath, parameters: object, encoding: .JSON, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }
}
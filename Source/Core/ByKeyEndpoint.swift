//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    All endpoints capable of being retrieved by key should conform to this protocol.

    Default implementation provides retrieval by key capability for all Commercetools endpoints which do support it.
*/
public protocol ByKeyEndpoint: Endpoint {

    /**
        Retrieves an object by UUID at the endpoint specified with `path` value.

        - parameter key:                      The key value used retrieve resource.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func byKey(key: String, expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)

}

public extension ByKeyEndpoint {

    static func byKey(key: String, expansion: [String]? = nil, result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute byKey command - check if the configuration is valid.")
            result(Result.Failure([Error.error(code: .GeneralCommercetoolsError)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure([error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion("\(path)key=\(key)", expansion: expansion)

            Alamofire.request(.GET, fullPath, parameters: nil, encoding: .JSON, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }
}
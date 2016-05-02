//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    All endpoints capable of being updated by key should conform to this protocol.

    Default implementation provides update by key capability for all Commercetools endpoints which do support it.
*/
public protocol UpdateByKeyEndpoint: Endpoint {

    /**
        Updates an object by UUID at the endpoint specified with `path` value.

        - parameter key:                      The key value used to reference resource to be updated.
        - parameter version:                  Version of the object (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func updateByKey(key: String, version: UInt, actions: [[String: AnyObject]], expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)

}

public extension UpdateByKeyEndpoint {

    static func updateByKey(key: String, version: UInt, actions: [[String: AnyObject]], expansion: [String]? = nil, result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute update by key command - check if the configuration is valid.")
            result(Result.Failure([Error.error(code: .GeneralCommercetoolsError)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure([error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion("\(path)key=\(key)", expansion: expansion)

            Alamofire.request(.POST, fullPath, parameters: ["version": version, "actions": actions], encoding: .JSON, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }
}
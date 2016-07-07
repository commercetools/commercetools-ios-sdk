//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    All endpoints capable of being updated by UUID should conform to this protocol.

    Default implementation provides update by UUID capability for all Commercetools endpoints which do support it.
*/
public protocol UpdateEndpoint: Endpoint {

    /**
        Updates an object by UUID at the endpoint specified with `path` value.

        - parameter id:                       Unique ID of the object to be deleted.
        - parameter version:                  Version of the object (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func update(id: String, version: UInt, actions: [[String: AnyObject]], expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)

}

public extension UpdateEndpoint {

    static func update(id: String, version: UInt, actions: [[String: AnyObject]], expansion: [String]? = nil, result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute update command - check if the configuration is valid.")
            result(Result.Failure(nil, [Error.error(code: .GeneralCommercetoolsError)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure(nil, [error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion(path + id, expansion: expansion)

            Alamofire.request(.POST, fullPath, parameters: ["version": version, "actions": actions], encoding: .JSON, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }
}
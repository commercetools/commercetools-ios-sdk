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
        - parameter result:                   The code to be executed after processing the response.
    */
    static func delete(id: String, version: UInt, expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)

}

public extension DeleteEndpoint {

    static func delete(id: String, version: UInt, expansion: [String]? = nil, result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute delete command - check if the configuration is valid.")
            Error.error(code: .GeneralCommercetoolsError)
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure([error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion(path + id, expansion: expansion)

            Alamofire.request(.DELETE, fullPath, parameters: ["version": version], encoding: .URL, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }
}
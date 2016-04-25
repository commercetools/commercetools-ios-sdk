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
        - parameter result:                   The code to be executed after processing the response. Either one of two
                                              optionals (response dictionary or an array) will have some value,
                                              depending on the request's success.
    */
    static func create(object: [String: AnyObject], expansion: [String]?, result: Result)

}

public extension CreateEndpoint {

    static func create(object: [String: AnyObject], expansion: [String]? = nil, result: Result) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute create command - check if the configuration is valid.")
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(nil, [error ?? Error.error(code: .GeneralCommercetoolsError)])
                return
            }

            let fullPath = expansion?.count > 0 ? pathWithExpansion(path, expansion: expansion!) : path

            Alamofire.request(.POST, fullPath, parameters: object, encoding: .JSON, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }
}
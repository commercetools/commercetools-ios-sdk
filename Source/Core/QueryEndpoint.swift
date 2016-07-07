//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    All endpoints capable of being queried should conform to this protocol.

    Default implementation provides querying capability for all Commercetools endpoints which do support it.
*/
public protocol QueryEndpoint: Endpoint {

    /**
        Queries for objects at the endpoint specified with `path` value.

        - parameter predicate:                An optional array of predicates used for querying for objects.
        - parameter sort:                     An optional array of sort options used for sorting the results.
        - parameter expansion:                An optional array of expansion property names.
        - parameter limit:                    An optional parameter to limit the number of returned results.
        - parameter offset:                   An optional parameter to set the offset of the first returned result.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func query(predicates predicates: [String]?, sort: [String]?, expansion: [String]?,
                      limit: UInt?, offset: UInt?, result: (Result<[String: AnyObject], NSError>) -> Void)

}

public extension QueryEndpoint {

    static func query(predicates predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil,
                      limit: UInt? = nil, offset: UInt? = nil, result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute query command - check if the configuration is valid.")
            result(Result.Failure(nil, [Error.error(code: .GeneralCommercetoolsError)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure(nil, [error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion(path, expansion: expansion)
            let parameters = queryParameters(predicates: predicates, sort: sort, limit: limit, offset: offset)

            Alamofire.request(.GET, fullPath, parameters: parameters, encoding: .URL, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }

    static func queryParameters(predicates predicates: [String]? = nil, sort: [String]? = nil, limit: UInt? = nil,
                                offset: UInt? = nil) -> [String: AnyObject] {
        var parameters = [String: AnyObject]()

        if let predicates = predicates where predicates.count > 0 {
            parameters["where"] = predicates
        }
        if let sort = sort where sort.count > 0 {
            parameters["sort"] = sort
        }
        if let limit = limit {
            parameters["limit"] = limit
        }
        if let offset = offset {
            parameters["offset"] = offset
        }
        return parameters
    }
}
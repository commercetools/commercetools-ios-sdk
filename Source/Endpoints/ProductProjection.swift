//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    Provides complete set of interactions for querying, retrieving and creating an order.
*/
public class ProductProjection: QueryEndpoint, ByIdEndpoint {

    // MARK: - Properties

    public static let path = "product-projections"

    // MARK: - Product projection endpoint functionality

    /**
        Queries for product projection.

        - parameter staged:                   An optional bool value, determining whether to query
                                              for the current or staged projections.
        - parameter predicate:                An optional array of predicates used for querying for  product projections.
        - parameter sort:                     An optional array of sort options used for sorting the results.
        - parameter expansion:                An optional array of expansion property names.
        - parameter limit:                    An optional parameter to limit the number of returned results.
        - parameter offset:                   An optional parameter to set the offset of the first returned result.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func query(staged staged: Bool? = nil, predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil,
                      limit: UInt? = nil, offset: UInt? = nil, result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute query command - check if the configuration is valid.")
            result(Result.Failure([Error.error(code: .GeneralCommercetoolsError)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure([error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion(path, expansion: expansion)
            var parameters = paramsWithStaged(staged, params: queryParameters(predicates: predicates, sort: sort,
                                              expansion: expansion, limit: limit, offset: offset))

            Alamofire.request(.GET, fullPath, parameters: parameters, encoding: .URL, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }

    /**
        Retrieves a product projection by UUID.

        - parameter staged:                   An optional bool value, determining whether to retrieve current or staged
                                              product projection variant.
        - parameter id:                       Unique ID of the product projection to be retrieved.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func byId(id: String, staged: Bool? = nil, expansion: [String]? = nil, result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute byId command - check if the configuration is valid.")
            result(Result.Failure([Error.error(code: .GeneralCommercetoolsError)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure([error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion(path + id, expansion: expansion)

            Alamofire.request(.GET, fullPath, parameters: paramsWithStaged(staged), encoding: .URL, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }

    private static func paramsWithStaged(staged: Bool?, params: [String: AnyObject]? = nil) -> [String: AnyObject] {
        var params = params ?? [String: AnyObject]()

        if let staged = staged {
            params["staged"] = staged ? "true" : "false"
        }

        return params
    }

}
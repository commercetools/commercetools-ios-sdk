//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    GraphQL endpoint implementation, providing the ability to query for data with queries, passing optional variables and
    operation name. Currently, providing only raw JSON response (dictionary representation).
*/
open class GraphQL: Endpoint {

    public typealias ResponseType = NoMapping

    open static let path = "graphql"

    /**
        Executes GraphQL query, providing result in raw JSON format (dictionary representation).

        - parameter query:                    String representing GraphQL query.
        - parameter variables:                Optional dictionary object containing values for variables defined in the query.
        - parameter operationName:            Operation name, in case there are several defined in the query.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func query(_ query: String, variables: [String: Any]? = nil, operationName: String? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            var parameters: [String: Any] = ["query": query]
            if let variables = variables {
                parameters["variables"] = variables
            }
            if let operationName = operationName {
                parameters["operationName"] = operationName
            }
            let request = self.request(url: path, method: .post, json: parameters, headers: self.headers(token))

            perform(request: request) { (response: Result<ResponseType>) in
                result(response)
            }
        })
    }
}

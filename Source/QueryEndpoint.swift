//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

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
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    static func query(predicates: [String]?, sort: [String]?, expansion: [String]?, limit: UInt?, offset: UInt?, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void)

}

public class QueryResponse<ResponseType: Codable>: Codable {
    
    // MARK: - Properties
    
    public let offset: UInt
    public let count: UInt
    public let total: UInt
    public let results: [ResponseType]
    
    public init (offset: UInt, count: UInt, total: UInt, results: [ResponseType]) {
        self.offset = offset
        self.count = count
        self.total = total
        self.results = results
    }
}

public extension QueryEndpoint {

    static func query(predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil, limit: UInt? = nil, offset: UInt? = nil, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void) {
        query(predicates: predicates, sort: sort, expansion: expansion, limit: limit, offset: offset, path: Self.path, result: result)
    }

    static func query(predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil, limit: UInt? = nil, offset: UInt? = nil, path: String, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void) {

        requestWithTokenAndPath(relativePath: path, result: result) { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)
            let parameters = queryParameters(predicates: predicates, sort: sort, limit: limit, offset: offset)
            let request = self.request(url: fullPath, queryItems: parameters, headers: self.headers(token))

            perform(request: request) { (response: Result<QueryResponse<ResponseType>>) in
                result(response)
            }
        }
    }

    static func queryParameters(predicates: [String]? = nil, sort: [String]? = nil, limit: UInt? = nil, offset: UInt? = nil) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        predicates?.forEach {
            queryItems.append(URLQueryItem(name: "where", value: $0))
        }
        sort?.forEach {
            queryItems.append(URLQueryItem(name: "sort", value: $0))
        }
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        }
        if let offset = offset {
            queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        return queryItems
    }

    static func formParameters(predicates: [String]? = nil, sort: [String]? = nil, limit: UInt? = nil, offset: UInt? = nil) -> [FormParameter] {
        var parameters = [FormParameter]()

        predicates?.forEach {
            parameters.append(FormParameter(key: "where", value: $0))
        }
        sort?.forEach {
            parameters.append(FormParameter(key: "sort", value: $0))
        }
        if let limit = limit {
            parameters.append(FormParameter(key: "limit", value: String(limit)))
        }
        if let offset = offset {
            parameters.append(FormParameter(key: "offset", value: String(offset)))
        }
        return parameters
    }
}

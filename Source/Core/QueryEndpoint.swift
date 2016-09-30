//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Alamofire
import ObjectMapper

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
    static func query(predicates: [String]?, sort: [String]?, expansion: [String]?,
                      limit: UInt?, offset: UInt?, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void)
    
    /**
        Queries for objects at the endpoint specified with `path` value.

        - parameter predicate:                An optional array of predicates used for querying for objects.
        - parameter sort:                     An optional array of sort options used for sorting the results.
        - parameter expansion:                An optional array of expansion property names.
        - parameter limit:                    An optional parameter to limit the number of returned results.
        - parameter offset:                   An optional parameter to set the offset of the first returned result.
        - parameter dictionaryResult:         The code to be executed after processing the response, containing result
                                              in dictionary format in case of a success.
     */
    static func query(predicates: [String]?, sort: [String]?, expansion: [String]?,
                      limit: UInt?, offset: UInt?, dictionaryResult: @escaping (Result<[String: Any]>) -> Void)

}

public class QueryResponse<ResponseType: Mappable>: Mappable {
    
    public required init?(map: Map) {}
    
    // MARK: - Properties
    
    var offset: UInt?
    var count: UInt?
    var total: UInt?
    var results: [ResponseType]?
    
    // MARK: - Mappable
    
    public func mapping(map: Map) {
        offset           <- map["offset"]
        count            <- map["count"]
        total            <- (map["total"])
        results          <- (map["results"])
    }
}

public extension QueryEndpoint {
    
    static func query(predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil,
                      limit: UInt? = nil, offset: UInt? = nil, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void) {
        query(predicates: predicates, sort: sort, expansion: expansion, limit: limit, offset: offset,
              result: result, completionHandler: { response in
            handleResponse(response, result: result)
        })
    }
    
    static func query(predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil,
                      limit: UInt? = nil, offset: UInt? = nil, dictionaryResult: @escaping (Result<[String: Any]>) -> Void) {
        query(predicates: predicates, sort: sort, expansion: expansion, limit: limit, offset: offset,
               result: dictionaryResult, completionHandler: { response in
            handleResponse(response, result: dictionaryResult)
        })
    }
    
    private static func query<T>(predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil,
                              limit: UInt? = nil, offset: UInt? = nil, result: @escaping (Result<T>) -> Void,
                              completionHandler: @escaping (DataResponse<Any>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)
            let parameters = queryParameters(predicates: predicates, sort: sort, limit: limit, offset: offset)
            
            Alamofire.request(fullPath, parameters: parameters, encoding: URLEncoding.queryString, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: completionHandler)
        })
    }

    static func queryParameters(predicates: [String]? = nil, sort: [String]? = nil, limit: UInt? = nil,
                                offset: UInt? = nil) -> [String: Any] {
        var parameters = [String: Any]()

        if let predicates = predicates, predicates.count > 0 {
            parameters["where"] = predicates
        }
        if let sort = sort, sort.count > 0 {
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

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Alamofire
import ObjectMapper

/**
    All endpoints capable of being updated by UUID should conform to this protocol.

    Default implementation provides update by UUID capability for all Commercetools endpoints which do support it.
*/
public protocol UpdateEndpoint: Endpoint {

    associatedtype UpdateAction: JSONRepresentable

    /**
        Updates an object by UUID at the endpoint specified with `path` value.

        - parameter id:                       Unique ID of the object to be deleted.
        - parameter actions:                  `UpdateActions`instance, containing correct version and update actions.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    static func update(_ id: String, actions: UpdateActions<UpdateAction>, expansion: [String]?, result: @escaping (Result<ResponseType>) -> Void)

    /**
        Updates an object by UUID at the endpoint specified with `path` value.

        - parameter id:                       Unique ID of the object to be deleted.
        - parameter version:                  Version of the object (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    static func update(_ id: String, version: UInt, actions: [[String: Any]], expansion: [String]?, result: @escaping (Result<ResponseType>) -> Void)
}

/**
    This protocol requires a property for JSON dictionary representation.

    All update actions should conform to this protocol.
*/
public protocol JSONRepresentable {
    var toJSON: [String: Any] { get }
}

/**
    Struct containing version of the object to be updated, as well as an array of update actions.
*/
public struct UpdateActions<T: JSONRepresentable>: JSONRepresentable {

    public init(version: UInt, actions: [T]) {
        self.version = version
        self.actions = actions
    }

    // MARK: - Properties

    public var version: UInt
    public var actions: [T]

    public var toJSON: [String: Any] {
        return ["version": version, "actions": actions.map({ $0.toJSON })]
    }
}

public extension UpdateEndpoint {

    static func update(_ id: String, actions: UpdateActions<UpdateAction>, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path + id, expansion: expansion)

            Alamofire.request(fullPath, method: .post, parameters: actions.toJSON, encoding: JSONEncoding.default, headers: self.headers(token))
                    .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                        handleResponse(response, result: result)
                    })
        })
    }
    
    static func update(_ id: String, version: UInt, actions: [[String: Any]], expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        
        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path + id, expansion: expansion)
            
            Alamofire.request(fullPath, method: .post, parameters: ["version": version, "actions": actions], encoding: JSONEncoding.default, headers: self.headers(token))
                .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                    handleResponse(response, result: result)
                })
        })
    }
}

public extension JSONRepresentable {
    func toJSON<T: Mappable>(_ options: T) -> [String: Any] {
        return Mapper<T>().toJSON(options)
    }
}
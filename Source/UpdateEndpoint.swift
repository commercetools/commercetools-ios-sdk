//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    All endpoints capable of being updated by UUID should conform to this protocol.

    Default implementation provides update by UUID capability for all Commercetools endpoints which do support it.
*/
public protocol UpdateEndpoint: Endpoint {

    associatedtype UpdateAction: JSONRepresentable

    /**
        Updates an object by UUID at the endpoint specified with `path` value.

        - parameter id:                       Unique ID of the object to be updated.
        - parameter actions:                  `UpdateActions`instance, containing correct version and update actions.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    static func update(_ id: String, actions: UpdateActions<UpdateAction>, expansion: [String]?, result: @escaping (Result<ResponseType>) -> Void)

    /**
        Updates an object by UUID at the endpoint specified with `path` value.

        - parameter id:                       Unique ID of the object to be updated.
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
    var toJSON: [String: Any]? { get }
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

    public var toJSON: [String: Any]? {
        return ["version": version, "actions": actions.map({ $0.toJSON })]
    }
}

public extension UpdateEndpoint {

    static func update(_ id: String, actions: UpdateActions<UpdateAction>, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        update(id, actions: actions, expansion: expansion, path: Self.path, result: result)
    }

    static func update(_ id: String, actions: UpdateActions<UpdateAction>, expansion: [String]? = nil, path: String, result: @escaping (Result<ResponseType>) -> Void) {

        requestWithTokenAndPath(relativePath: path, result: result) { token, path in
            let fullPath = pathWithExpansion(path + id, expansion: expansion)
            let request = self.request(url: fullPath, method: .post, json: actions.toJSON, headers: self.headers(token))

            perform(request: request) { (response: Result<ResponseType>) in
                result(response)
            }
        }
    }

    static func update(_ id: String, version: UInt, actions: [[String: Any]], expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        update(id, version: version, actions: actions, expansion: expansion, path: Self.path, result: result)
    }

    static func update(_ id: String, version: UInt, actions: [[String: Any]], expansion: [String]? = nil, path: String, result: @escaping (Result<ResponseType>) -> Void) {

        requestWithTokenAndPath(relativePath: path, result: result) { token, path in
            let fullPath = pathWithExpansion(path + id, expansion: expansion)
            let request = self.request(url: fullPath, method: .post, json: ["version": version, "actions": actions], headers: self.headers(token))

            perform(request: request) { (response: Result<ResponseType>) in
                result(response)
            }
        }
    }
}

public extension JSONRepresentable {
    func filterJSON(parameters: [String: Any?]) -> [String: Any]? {
        let filteredParameters = parameters.filter({ $0.value != nil })
        return filteredParameters as [String : Any]
    }
}

extension Encodable {
    public var toJSON: [String: Any]? {
        guard let data = try? jsonEncoder.encode(self),
              let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return nil }
        return json as? [String: Any]
    }
}

extension JsonValue {
    public var toJSON: Any? {
        switch self {
        case .bool(let boolValue):
            return boolValue
        case .int(let intValue):
            return intValue
        case .double(let doubleValue):
            return doubleValue
        case .string(let stringValue):
            return stringValue
        case .dictionary(let dictionaryValue):
            return dictionaryValue.reduce([String: Any]()) {
                if let value = $1.value.toJSON {
                    var result = $0
                    result[$1.key] = value
                    return result
                }
                return $0
            }
        case .array(let arrayValue):
            return arrayValue.map { $0.toJSON }
        case .unknown:
            return nil
        }
    }
}

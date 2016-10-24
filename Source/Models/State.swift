//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct State: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var key: String?
    public var type: StateType?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var initial: Bool?
    public var builtIn: Bool?
    public var roles: [StateRole]?
    public var transitions: [Reference<State>]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        version           <- map["version"]
        createdAt         <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt    <- (map["lastModifiedAt"], ISO8601DateTransform())
        key               <- map["key"]
        type              <- map["type"]
        name              <- map["name"]
        description       <- map["description"]
        initial           <- map["initial"]
        builtIn           <- map["builtIn"]
        roles             <- map["roles"]
        transitions       <- map["transitions"]
    }

}

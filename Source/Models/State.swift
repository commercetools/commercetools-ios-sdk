//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct State: Mappable {

    // MARK: - Properties

    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var key: String?
    var type: StateType?
    var name: LocalizedString?
    var description: LocalizedString?
    var initial: Bool?
    var builtIn: Bool?
    var roles: [StateRole]?
    var transitions: [Reference<State>]?

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

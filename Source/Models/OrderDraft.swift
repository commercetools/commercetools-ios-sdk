//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct OrderDraft: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                          <- map["id"]
        version                     <- map["version"]
    }
}

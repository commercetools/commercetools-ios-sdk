//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct OrderDraft: Mappable {

    // MARK: - Properties

    var id: String?
    var version: UInt?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                          <- map["id"]
        version                     <- map["version"]
    }
}

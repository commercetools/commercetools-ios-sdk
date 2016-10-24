//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Attribute: Mappable {

    // MARK: - Properties

    public var name: String?
    public var value: AnyObject?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        name               <- map["name"]
        value              <- map["value"]
    }
}

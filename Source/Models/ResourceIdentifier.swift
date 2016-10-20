//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ResourceIdentifier: Mappable {

    // MARK: - Properties

    public var id: String?
    public var typeId: String?
    public var key: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                 <- map["id"]
        typeId             <- map["typeId"]
        key                <- map["key"]
    }
}

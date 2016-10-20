//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ItemState: Mappable {

    // MARK: - Properties

    public var quantity: Int?
    public var state: Reference<State>?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        quantity                <- map["quantity"]
        state                   <- map["state"]
    }

}

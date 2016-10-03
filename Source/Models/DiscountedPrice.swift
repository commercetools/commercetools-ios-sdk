//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct DiscountedPrice: Mappable {

    // MARK: - Properties

    var value: Money?
    var discount: [String: AnyObject]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        value              <- map["value"]
        discount           <- map["discount"]
    }

}

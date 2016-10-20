//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct DiscountedPrice: Mappable {

    // MARK: - Properties

    public var value: Money?
    public var discount: Reference<ProductDiscount>?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        value              <- map["value"]
        discount           <- map["discount"]
    }
}

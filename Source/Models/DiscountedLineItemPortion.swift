//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct DiscountedLineItemPortion: Mappable {

    // MARK: - Properties

    var discount: Reference<CartDiscount>?
    var discountedAmount: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        discount          <- map["discount"]
        discountedAmount  <- map["discountedAmount"]
    }

}

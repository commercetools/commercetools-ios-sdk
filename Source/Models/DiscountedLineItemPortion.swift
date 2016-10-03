//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct DiscountedLineItemPortion: Mappable {

    // MARK: - Properties

    var discount: Reference<CartDiscount>?
    var discountedAmount: Money?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        discount          <- map["discount"]
        discountedAmount  <- map["discountedAmount"]
    }

}

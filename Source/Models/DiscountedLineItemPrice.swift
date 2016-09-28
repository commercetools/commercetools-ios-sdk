//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct DiscountedLineItemPrice: Mappable {

    // MARK: - Properties

    var value: Money?
    var includedDiscounts: [String: AnyObject]?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        value             <- map["value"]
        includedDiscounts <- map["includedDiscounts"]
    }

}

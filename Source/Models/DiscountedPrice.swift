//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct DiscountedPrice: Mappable {

    // MARK: - Properties

    var value: Money?
    var discount: [String: AnyObject]?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        value              <- map["value"]
        discount           <- map["discount"]
    }

}

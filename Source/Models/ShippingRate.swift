//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct ShippingRate: Mappable {

    // MARK: - Properties

    var price: Money?
    var freeAbove: Money?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        price             <- map["price"]
        freeAbove         <- map["freeAbove"]
    }

}

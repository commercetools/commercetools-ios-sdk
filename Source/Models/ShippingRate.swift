//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ShippingRate: Mappable {

    // MARK: - Properties

    var price: Money?
    var freeAbove: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        price             <- map["price"]
        freeAbove         <- map["freeAbove"]
    }

}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ZoneRate: Mappable {

    // MARK: - Properties

    var zone: Reference<Zone>?
    var shippingRates: [ShippingRate]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        zone              <- map["zone"]
        shippingRates     <- map["shippingRates"]
    }

}

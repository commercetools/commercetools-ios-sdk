//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct ZoneRate: Mappable {

    // MARK: - Properties

    var zone: Reference<Zone>?
    var shippingRates: [ShippingRate]?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        zone              <- map["zone"]
        shippingRates     <- map["shippingRates"]
    }

}

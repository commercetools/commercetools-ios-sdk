//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct Price: Mappable {

    // MARK: - Properties

    var value: Money?
    var country: String?
    var customerGroup: [String: AnyObject]?
    var channel: Channel?
    var validFrom: Date?
    var validUntil: Date?
    var discounted: DiscountedPrice?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        value              <- map["value"]
        country            <- map["country"]
        customerGroup      <- map["customerGroup"]
        channel            <- map["channel"]
        validFrom          <- (map["validFrom"], ISO8601DateTransform())
        validUntil         <- (map["validUntil"], ISO8601DateTransform())
        discounted         <- map["discounted"]
    }

}

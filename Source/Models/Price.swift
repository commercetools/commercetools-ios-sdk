//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Price: Mappable {

    // MARK: - Properties

    var value: Money?
    var country: String?
    var customerGroup: Reference<CustomerGroup>?
    var channel: Reference<Channel>?
    var validFrom: Date?
    var validUntil: Date?
    var discounted: DiscountedPrice?
    var custom: [String: Any]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        value              <- map["value"]
        country            <- map["country"]
        customerGroup      <- map["customerGroup"]
        channel            <- map["channel"]
        validFrom          <- (map["validFrom"], ISO8601DateTransform())
        validUntil         <- (map["validUntil"], ISO8601DateTransform())
        discounted         <- map["discounted"]
        custom             <- map["custom"]
    }
}

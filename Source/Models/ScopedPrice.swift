//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ScopedPrice: Mappable {

    // MARK: - Properties

    var id: String?
    var value: Money?
    var currentValue: Money?
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
        id                   <- map["id"]
        value                <- map["value"]
        currentValue         <- map["currentValue"]
        country              <- map["country"]
        customerGroup        <- map["customerGroup"]
        channel              <- map["channel"]
        validFrom            <- map["validFrom"]
        validUntil           <- map["validUntil"]
        discounted           <- map["discounted"]
        custom               <- map["custom"]
    }
}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ScopedPrice: Mappable {

    // MARK: - Properties

    public var id: String?
    public var value: Money?
    public var currentValue: Money?
    public var country: String?
    public var customerGroup: Reference<CustomerGroup>?
    public var channel: Reference<Channel>?
    public var validFrom: Date?
    public var validUntil: Date?
    public var discounted: DiscountedPrice?
    public var custom: [String: Any]?

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

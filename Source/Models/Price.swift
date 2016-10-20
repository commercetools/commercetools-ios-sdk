//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Price: Mappable {

    // MARK: - Properties

    public var value: Money?
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

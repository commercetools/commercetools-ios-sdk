//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ExternalTaxRateDraft: Mappable {

    // MARK: - Properties

    public var name: String?
    public var amount: Double?
    public var country: String?
    public var state: String?
    public var subRates: [SubRate]?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        name                   <- map["name"]
        amount                 <- map["amount"]
        country                <- map["country"]
        state                  <- map["state"]
        subRates               <- map["subRates"]
    }
}

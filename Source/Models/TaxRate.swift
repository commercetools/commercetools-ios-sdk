//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct TaxRate: Mappable {

    // MARK: - Properties

    public var id: String?
    public var name: String?
    public var includedInPrice: Bool?
    public var country: String?
    public var state: String?
    public var subRates: [SubRate]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        name              <- map["name"]
        includedInPrice   <- map["includedInPrice"]
        country           <- map["country"]
        state             <- map["state"]
        subRates          <- map["subRates"]
    }

}

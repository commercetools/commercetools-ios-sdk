//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct TaxRate: Mappable {

    // MARK: - Properties

    var id: String?
    var name: String?
    var includedInPrice: Bool?
    var country: String?
    var state: String?
    var subRates: [SubRate]?

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

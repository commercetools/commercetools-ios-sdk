//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ShippingMethod: Mappable {

    // MARK: - Properties

    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var name: String?
    var description: String?
    var taxCategory: Reference<TaxCategory>?
    var zoneRates: [ZoneRate]?
    var isDefault: Bool?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id               <- map["id"]
        version          <- map["version"]
        createdAt        <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt   <- (map["lastModifiedAt"], ISO8601DateTransform())
        name             <- map["name"]
        description      <- map["description"]
        taxCategory      <- map["taxCategory"]
        zoneRates        <- map["zoneRates"]
        isDefault        <- map["isDefault"]
    }

}

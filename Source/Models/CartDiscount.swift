//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct CartDiscount: Mappable {

    // MARK: - Properties

    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var name: LocalizedString?
    var description: LocalizedString?
    var value: CartDiscountValue?
    var cartPredicate: String?
    var target: CartDiscountTarget?
    var sortOrder: String?
    var isActive: Bool?
    var validFrom: Date?
    var validUntil: Date?
    var requiresDiscountCode: Bool?
    var references: [GenericReference]?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        id                    <- map["id"]
        version               <- map["version"]
        createdAt             <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt        <- (map["lastModifiedAt"], ISO8601DateTransform())
        name                  <- map["name"]
        description           <- map["description"]
        value                 <- map["value"]
        cartPredicate         <- map["cartPredicate"]
        target                <- map["target"]
        sortOrder             <- map["sortOrder"]
        isActive              <- map["isActive"]
        validFrom             <- (map["validFrom"], ISO8601DateTransform())
        validUntil            <- (map["validUntil"], ISO8601DateTransform())
        requiresDiscountCode  <- map["requiresDiscountCode"]
        references            <- map["references"]
    }

}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct CartDiscount: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var value: CartDiscountValue?
    public var cartPredicate: String?
    public var target: CartDiscountTarget?
    public var sortOrder: String?
    public var isActive: Bool?
    public var validFrom: Date?
    public var validUntil: Date?
    public var requiresDiscountCode: Bool?
    public var references: [GenericReference]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
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

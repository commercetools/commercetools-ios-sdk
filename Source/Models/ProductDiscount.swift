//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ProductDiscount: Mappable {

    // MARK: - Properties

    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var name: LocalizedString?
    var description: LocalizedString?
    var value: ProductDiscountValue?
    var predicate: String?
    var sortOrder: String?
    var isActive: Bool?
    var references: [GenericReference]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        version           <- map["version"]
        createdAt         <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt    <- (map["lastModifiedAt"], ISO8601DateTransform())
        name              <- map["name"]
        description       <- map["description"]
        value             <- map["value"]
        predicate         <- map["predicate"]
        sortOrder         <- map["sortOrder"]
        isActive          <- map["isActive"]
        references        <- map["references"]
    }
}

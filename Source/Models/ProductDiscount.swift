//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ProductDiscount: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var value: ProductDiscountValue?
    public var predicate: String?
    public var sortOrder: String?
    public var isActive: Bool?
    public var references: [GenericReference]?

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

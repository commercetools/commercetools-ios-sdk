//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

/**
    Provides set of interactions for querying, retrieving by UUID and by key for product types.
*/
open class ProductType: ByIdEndpoint, ByKeyEndpoint, QueryEndpoint, Mappable {
    
    public typealias ResponseType = ProductType

    open static let path = "product-types"

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var key: String?
    public var name: String?
    public var description: String?
    public var attributes: [AttributeDefinition]?

    public required init?(map: Map) {}

    // MARK: - Mappable

    public func mapping(map: Map) {
        id               <- map["id"]
        version          <- map["version"]
        createdAt        <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt   <- (map["lastModifiedAt"], ISO8601DateTransform())
        key              <- map["key"]
        name             <- map["name"]
        description      <- map["description"]
        attributes       <- map["attributes"]
    }
}
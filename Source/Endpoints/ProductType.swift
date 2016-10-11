//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

/**
    Provides set of interactions for querying, retrieving by UUID and by key for product types.
*/
open class ProductType: ByIdEndpoint, ByKeyEndpoint, QueryEndpoint, Mappable {
    
    public typealias ResponseType = NoMapping

    open static let path = "product-types"

    // MARK: - Properties

    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var key: String?
    var name: String?
    var description: String?
    var attributes: [AttributeDefinition]?

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
//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import ObjectMapper

/**
    Provides set of interactions for querying, retrieving by UUID and by key for product types.
*/
open class ProductType: ByIdEndpoint, ByKeyEndpoint, QueryEndpoint, ImmutableMappable {
    
    public typealias ResponseType = ProductType

    open static let path = "product-types"

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let key: String?
    public let name: String
    public let description: String
    public let attributes: [AttributeDefinition]

    // MARK: - Mappable

    public required init(map: Map) throws {
        id               = try map.value("id")
        version          = try map.value("version")
        createdAt        = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt   = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        key              = try? map.value("key")
        name             = try map.value("name")
        description      = try map.value("description")
        attributes       = try map.value("attributes")
    }
}
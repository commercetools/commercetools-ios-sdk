//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import ObjectMapper

/**
    Provides set of interactions for querying and retrieving by UUID for categories.
*/
open class Category: ByIdEndpoint, ByKeyEndpoint, QueryEndpoint, ImmutableMappable {
    
    public typealias ResponseType = Category

    open static let path = "categories"

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let key: String?
    public let name: LocalizedString
    public let slug: LocalizedString
    public let description: LocalizedString?
    public let ancestors: [Reference<Category>]
    public let parent: Reference<Category>?
    public let orderHint: String?
    public let externalId: String?
    public let metaTitle: LocalizedString?
    public let metaDescription: LocalizedString?
    public let metaKeywords: LocalizedString?
    public let custom: [String: Any]?
    public let assets: [Asset]

    // MARK: - Mappable

    public required init(map: Map) throws {
        id                      = try map.value("id")
        version                 = try map.value("version")
        createdAt               = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt          = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        key                     = try? map.value("key")
        name                    = try map.value("name")
        slug                    = try map.value("slug")
        description             = try? map.value("description")
        ancestors               = try map.value("ancestors")
        parent                  = try? map.value("parent")
        orderHint               = try? map.value("orderHint")
        externalId              = try? map.value("externalId")
        metaTitle               = try? map.value("metaTitle")
        metaDescription         = try? map.value("metaDescription")
        metaKeywords            = try? map.value("metaKeywords")
        custom                  = try? map.value("custom")
        assets                  = try map.value("assets")
    }
}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

/**
    Provides set of interactions for querying and retrieving by UUID for categories.
*/
open class Category: ByIdEndpoint, QueryEndpoint, Mappable {
    
    public typealias ResponseType = Category

    open static let path = "categories"

    // MARK: - Properties

    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var name: LocalizedString?
    var slug: LocalizedString?
    var description: LocalizedString?
    var ancestors: [Reference<Category>]?
    var parent: Reference<Category>?
    var orderHint: String?
    var externalId: String?
    var metaTitle: LocalizedString?
    var metaDescription: LocalizedString?
    var metaKeywords: LocalizedString?
    var custom: [String: Any]?

    public required init?(map: Map) {}

    // MARK: - Mappable

    public func mapping(map: Map) {
        id                      <- map["id"]
        version                 <- map["version"]
        createdAt               <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt          <- (map["lastModifiedAt"], ISO8601DateTransform())
        name                    <- map["name"]
        slug                    <- map["slug"]
        description             <- map["description"]
        ancestors               <- map["ancestors"]
        parent                  <- map["parent"]
        orderHint               <- map["orderHint"]
        externalId              <- map["externalId"]
        metaTitle               <- map["metaTitle"]
        metaDescription         <- map["metaDescription"]
        metaKeywords            <- map["metaKeywords"]
        custom                  <- map["custom"]
    }
}

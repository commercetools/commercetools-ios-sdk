//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import ObjectMapper

/**
    Provides set of interactions for querying and retrieving by UUID for categories.
*/
open class Category: ByIdEndpoint, ByKeyEndpoint, QueryEndpoint, Mappable {
    
    public typealias ResponseType = Category

    open static let path = "categories"

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var key: String?
    public var name: LocalizedString?
    public var slug: LocalizedString?
    public var description: LocalizedString?
    public var ancestors: [Reference<Category>]?
    public var parent: Reference<Category>?
    public var orderHint: String?
    public var externalId: String?
    public var metaTitle: LocalizedString?
    public var metaDescription: LocalizedString?
    public var metaKeywords: LocalizedString?
    public var custom: [String: Any]?
    public var assets: [Asset]?

    public required init?(map: Map) {}

    // MARK: - Mappable

    public func mapping(map: Map) {
        id                      <- map["id"]
        version                 <- map["version"]
        createdAt               <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt          <- (map["lastModifiedAt"], ISO8601DateTransform())
        key                     <- map["key"]
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
        assets                  <- map["assets"]
    }
}

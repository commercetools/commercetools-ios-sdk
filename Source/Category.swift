//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides set of interactions for querying and retrieving by UUID for categories.
*/
public class Category: ByIdEndpoint, ByKeyEndpoint, QueryEndpoint, Codable {
    
    public typealias ResponseType = Category

    public static let path = "categories"

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
    public let custom: JsonValue?
    public let assets: [Asset]
    
    public init(id: String, version: UInt, createdAt: Date, lastModifiedAt: Date, key: String?, name: LocalizedString, slug: LocalizedString, description: LocalizedString?, ancestors: [Reference<Category>], parent: Reference<Category>?, orderHint: String?, externalId: String?, metaTitle: LocalizedString?, metaDescription: LocalizedString?, metaKeywords: LocalizedString?, custom: JsonValue?, assets: [Asset]) {
        self.id = id
        self.version = version
        self.createdAt = createdAt
        self.lastModifiedAt = lastModifiedAt
        self.key = key
        self.name = name
        self.slug = slug
        self.description = description
        self.ancestors = ancestors
        self.parent = parent
        self.orderHint = orderHint
        self.externalId = externalId
        self.metaTitle = metaTitle
        self.metaDescription = metaDescription
        self.metaKeywords = metaKeywords
        self.custom = custom
        self.assets = assets        
    }
}

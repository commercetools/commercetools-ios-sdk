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
    public let createdBy: CreatedBy?
    public let lastModifiedAt: Date
    public let lastModifiedBy: LastModifiedBy?
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
}

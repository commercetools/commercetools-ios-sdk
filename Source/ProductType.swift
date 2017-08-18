//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides set of interactions for querying, retrieving by UUID and by key for product types.
*/
public struct ProductType: ByIdEndpoint, ByKeyEndpoint, QueryEndpoint, Codable {
    
    public typealias ResponseType = ProductType

    public static let path = "product-types"

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let key: String?
    public let name: String
    public let description: String
    public let attributes: [AttributeDefinition]
}

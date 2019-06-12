//
// Copyright (c) 2017 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides complete set of interactions for querying, retrieving, creating and updating shopping lists.
 */
public struct ShoppingList: QueryEndpoint, ByIdEndpoint, CreateEndpoint, UpdateEndpoint, DeleteEndpoint, Codable {

    public typealias ResponseType = ShoppingList
    public typealias RequestDraft = ShoppingListDraft
    public typealias UpdateAction = ShoppingListUpdateAction

    public static let path = "me/shopping-lists"

    // MARK: - Properties

    public let id: String
    public let key: String?
    public let version: UInt
    public let createdAt: Date
    public let createdBy: CreatedBy?
    public let lastModifiedAt: Date
    public let lastModifiedBy: LastModifiedBy?
    public let slug: LocalizedString?
    public let name: LocalizedString
    public let description: LocalizedString?
    public let customer: Reference<Customer>?
    public let anonymousId: String?
    public let lineItems: [LineItem]
    public let textLineItems: [TextLineItem]
    public let custom: JsonValue?
    public let deleteDaysAfterLastModification: UInt?

    public struct LineItem: Codable {
        public let id: String
        public let productId: String
        public let variantId: Int?
        public let productType: Reference<ProductType>
        public let quantity: Int
        public let custom: JsonValue?
        public let addedAt: Date
        public let name: LocalizedString
        public let deactivatedAt: Date?
        public let productSlug: LocalizedString?
        public let variant: ProductVariant?
    }
}

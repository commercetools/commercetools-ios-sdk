//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides complete set of interactions for querying, retrieving, creating and updating shopping cart.
*/
public struct Cart: QueryEndpoint, ByIdEndpoint, CreateEndpoint, UpdateEndpoint, DeleteEndpoint, Codable {
    
    public typealias ResponseType = Cart
    public typealias RequestDraft = CartDraft
    public typealias UpdateAction = CartUpdateAction

    public static let path = "me/carts"

    // MARK: - Active cart

    /**
        Retrieves the cart with state Active which has the most recent lastModifiedAt.
     
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
     */
    public static func active(expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        requestWithTokenAndPath(relativePath: "me/active-cart", result: result) { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)
            let request = self.request(url: fullPath, headers: self.headers(token))

            perform(request: request) { (response: Result<ResponseType>) in
                result(response)
            }
        }
    }

    // MARK: - In store cart

    /**
        Retrieves the cart with state Active which has the most recent lastModifiedAt, for a store specified by key.

        - parameter storeKey:                 Key referencing the store for cart retrieval.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
     */
    public static func active(storeKey: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        requestWithTokenAndPath(relativePath: "in-store/key=\(storeKey)/me/active-cart", result: result) { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)
            let request = self.request(url: fullPath, headers: self.headers(token))

            perform(request: request) { (response: Result<ResponseType>) in
                result(response)
            }
        }
    }

    /**
        Queries for carts from a store specified by key.

        - parameter storeKey:                 Key referencing the store for query operation.
        - parameter predicate:                An optional array of predicates used for querying for carts.
        - parameter sort:                     An optional array of sort options used for sorting the results.
        - parameter expansion:                An optional array of expansion property names.
        - parameter limit:                    An optional parameter to limit the number of returned results.
        - parameter offset:                   An optional parameter to set the offset of the first returned result.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    public static func query(storeKey: String, predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil, limit: UInt? = nil, offset: UInt? = nil, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void) {
        query(predicates: predicates, sort: sort, expansion: expansion, limit: limit, offset: offset, path: inStorePath(storeKey: storeKey), result: result)
    }

    /**
        Retrieves a cart by UUID from a store specified by key.

        - parameter id:                       Unique ID of the cart to be retrieved.
        - parameter storeKey:                 Key referencing the store for cart retrieval.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    public static func byId(_ id: String, storeKey: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        byId(id, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    /**
        Creates new cart in a store specified by key.

        - parameter object:                   Dictionary representation of the cart draft to be created.
        - parameter storeKey:                 Key referencing the store where the new cart will be created.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func create(_ object: [String: Any]?, storeKey: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        create(object, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    /**
        Creates new cart in a store specified by key.

        - parameter object:                   CartDraft to be created.
        - parameter storeKey:                 Key referencing the store where the new cart will be created.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func create(_ object: RequestDraft, storeKey: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        create(object, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    /**
        Updates a cart with the specified UUID in a store.

        - parameter id:                       Unique ID of the cart to be deleted.
        - parameter storeKey:                 Key referencing the store used for the update.
        - parameter actions:                  `UpdateActions`instance, containing correct version and update actions.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    public static func update(_ id: String, storeKey: String, actions: UpdateActions<UpdateAction>, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        update(id, actions: actions, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    /**
        Updates a cart with the specified UUID in a store.

        - parameter id:                       Unique ID of the cart to be deleted.
        - parameter storeKey:                 Key referencing the store used for the update.
        - parameter version:                  Version of the cart (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    public static func update(_ id: String, storeKey: String, version: UInt, actions: [[String: Any]], expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        update(id, version: version, actions: actions, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    /**
        Deletes a cart by UUID from a store specified by key.

        - parameter id:                       Unique ID of the cart to be deleted.
        - parameter storeKey:                 Key referencing the store containing the cart.
        - parameter version:                  Version of the cart (for optimistic concurrency control).
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    public static func delete(_ id: String, storeKey: String, version: UInt, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        delete(id, version: version, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    private static func inStorePath(storeKey: String) -> String {
        return "in-store/key=\(storeKey)/me/carts"
    }

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let customerId: String?
    public let customerEmail: String?
    public let anonymousId: String?
    public let store: KeyReference?
    public let lineItems: [LineItem]
    public let customLineItems: [CustomLineItem]
    public let totalPrice: Money
    public let taxedPrice: TaxedPrice?
    public let cartState: CartState
    public let shippingAddress: Address?
    public let billingAddress: Address?
    public let inventoryMode: InventoryMode
    public let taxMode: TaxMode
    public let taxRoundingMode: RoundingMode
    public let customerGroup: Reference<CustomerGroup>?
    public let country: String?
    public let shippingInfo: ShippingInfo?
    public let discountCodes: [DiscountCodeInfo]
    public let refusedGifts: [Reference<CartDiscount>]
    public let custom: JsonValue?
    public let paymentInfo: PaymentInfo?
    public let locale: String?
    public let deleteDaysAfterLastModification: UInt?
    public let origin: CartOrigin
    public let createdAt: Date
    public let createdBy: CreatedBy?
    public let lastModifiedAt: Date
    public let lastModifiedBy: LastModifiedBy?
    public let itemShippingAddresses: [Address]
}
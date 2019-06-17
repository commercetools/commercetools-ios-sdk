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

    static func query(storeKey: String, predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil, limit: UInt? = nil, offset: UInt? = nil, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void) {
        query(predicates: predicates, sort: sort, expansion: expansion, limit: limit, offset: offset, path: inStorePath(storeKey: storeKey), result: result)
    }

    static func byId(_ id: String, storeKey: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        byId(id, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    static func create(_ object: [String: Any]?, storeKey: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        create(object, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    static func create(_ object: RequestDraft, storeKey: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        create(object, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    static func update(_ id: String, storeKey: String, actions: UpdateActions<UpdateAction>, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        update(id, actions: actions, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    static func update(_ id: String, storeKey: String, version: UInt, actions: [[String: Any]], expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        update(id, version: version, actions: actions, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    static func delete(_ id: String, storeKey: String, version: UInt, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
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
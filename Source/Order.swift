//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides complete set of interactions for querying, retrieving and creating an order.
*/
public struct Order: QueryEndpoint, ByIdEndpoint, CreateEndpoint, Codable {
    
    public typealias ResponseType = Order
    public typealias RequestDraft = OrderDraft

    public static let path = "me/orders"

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let createdBy: CreatedBy?
    public let lastModifiedAt: Date
    public let lastModifiedBy: LastModifiedBy?
    public let completedAt: Date?
    public let orderNumber: String?
    public let customerId: String?
    public let customerEmail: String?
    public let anonymousId: String?
    public let store: KeyReference?
    public let lineItems: [LineItem]
    public let customLineItems: [CustomLineItem]
    public let totalPrice: Money
    public let taxedPrice: TaxedPrice?
    public let shippingAddress: Address?
    public let billingAddress: Address?
    public let taxMode: TaxMode
    public let taxRoundingMode: RoundingMode
    public let customerGroup: Reference<CustomerGroup>?
    public let country: String?
    public let orderState: OrderState
    public let state: Reference<State>?
    public let shipmentState: ShipmentState?
    public let paymentState: PaymentState?
    public let shippingInfo: ShippingInfo?
    public let syncInfo: [SyncInfo]
    public let returnInfo: [ReturnInfo]
    public let discountCodes: [DiscountCodeInfo]
    public let lastMessageSequenceNumber: Int
    public let cart: Reference<Cart>?
    public let custom: JsonValue?
    public let paymentInfo: PaymentInfo?
    public let locale: String?
    public let inventoryMode: InventoryMode
    public let origin: CartOrigin
    public let itemShippingAddresses: [Address]

    // MARK: - Basic order methods

    /**
        Queries for orders.

        - parameter predicate:                An optional array of predicates used for querying for orders.
        - parameter sort:                     An optional array of sort options used for sorting the results.
        - parameter expansion:                An optional array of expansion property names.
        - parameter limit:                    An optional parameter to limit the number of returned results.
        - parameter offset:                   An optional parameter to set the offset of the first returned result.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    public static func query(predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil, limit: UInt? = nil, offset: UInt? = nil, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void) {
        if let storeKey = Config.currentConfig?.storeKey {
            query(storeKey: storeKey, predicates: predicates, sort: sort, expansion: expansion, limit: limit, offset: offset, result: result)
        } else {
            query(predicates: predicates, sort: sort, expansion: expansion, limit: limit, offset: offset, path: path, result: result)
        }
    }

    /**
        Retrieves an order by UUID.

        - parameter id:                       Unique ID of the order to be retrieved.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    public static func byId(_ id: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        if let storeKey = Config.currentConfig?.storeKey {
            byId(id, storeKey: storeKey, expansion: expansion, result: result)
        } else {
            byId(id, expansion: expansion, path: path, result: result)
        }
    }

    /**
        Creates a new order.

        - parameter object:                   Dictionary representation of the order draft to be created.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func create(_ object: [String: Any]?, expansion: [String]?, result: @escaping (Result<ResponseType>) -> Void) {
        if let storeKey = Config.currentConfig?.storeKey {
            create(object, storeKey: storeKey, expansion: expansion, result: result)
        } else {
            create(object, expansion: expansion, path: path, result: result)
        }
    }

    /**
        Creates a new order.

        - parameter object:                   OrderDraft object to be created.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func create(_ object: RequestDraft, expansion: [String]?, result: @escaping (Result<ResponseType>) -> Void) {
        if let storeKey = Config.currentConfig?.storeKey {
            create(object, storeKey: storeKey, expansion: expansion, result: result)
        } else {
            create(object, expansion: expansion, path: path, result: result)
        }
    }

    // MARK: - In store order

    /**
        Queries for orders from a store specified by key.

        - parameter storeKey:                 Key referencing the store for query operation.
        - parameter predicate:                An optional array of predicates used for querying for orders.
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
        Retrieves an order by UUID from a store specified by key.

        - parameter id:                       Unique ID of the order to be retrieved.
        - parameter storeKey:                 Key referencing the store for order retrieval.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response, providing model
                                              instance in case of a successful result.
    */
    public static func byId(_ id: String, storeKey: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        byId(id, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    /**
        Creates a new order in a store specified by key.

        - parameter object:                   Dictionary representation of the order draft to be created.
        - parameter storeKey:                 Key referencing the store where the new order will be created.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func create(_ object: [String: Any]?, storeKey: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        create(object, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    /**
        Creates a new order in a store specified by key.

        - parameter object:                   OrderDraft to be created.
        - parameter storeKey:                 Key referencing the store where the new order will be created.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func create(_ object: RequestDraft, storeKey: String, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        create(object, expansion: expansion, path: inStorePath(storeKey: storeKey), result: result)
    }

    private static func inStorePath(storeKey: String) -> String {
        return "in-store/key=\(storeKey)/me/orders"
    }
}

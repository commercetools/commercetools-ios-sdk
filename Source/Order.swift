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
}

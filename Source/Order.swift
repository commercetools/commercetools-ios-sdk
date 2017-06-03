//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import ObjectMapper

/**
    Provides complete set of interactions for querying, retrieving and creating an order.
*/
open class Order: QueryEndpoint, ByIdEndpoint, CreateEndpoint, ImmutableMappable {
    
    public typealias ResponseType = Order
    public typealias RequestDraft = OrderDraft

    open static let path = "me/orders"

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let completedAt: Date?
    public let orderNumber: String?
    public let customerId: String?
    public let customerEmail: String?
    public let anonymousId: String?
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
    public let custom: [String: Any]?
    public let paymentInfo: PaymentInfo?
    public let locale: String?
    public let inventoryMode: InventoryMode

    // MARK: - Mappable

    public required init(map: Map) throws {
        id                         = try map.value("id")
        version                    = try map.value("version")
        createdAt                  = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt             = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        completedAt                = try? map.value("completedAt", using: ISO8601DateTransform())
        orderNumber                = try? map.value("orderNumber")
        customerId                 = try? map.value("customerId")
        customerEmail              = try? map.value("customerEmail")
        anonymousId                = try? map.value("anonymousId")
        lineItems                  = try map.value("lineItems")
        customLineItems            = try map.value("customLineItems")
        totalPrice                 = try map.value("totalPrice")
        taxedPrice                 = try? map.value("taxedPrice")
        shippingAddress            = try? map.value("shippingAddress")
        billingAddress             = try? map.value("billingAddress")
        taxMode                    = try map.value("taxMode")
        taxRoundingMode            = try map.value("taxRoundingMode")
        customerGroup              = try? map.value("customerGroup")
        country                    = try? map.value("country")
        orderState                 = try map.value("orderState")
        state                      = try? map.value("state")
        shipmentState              = try? map.value("shipmentState")
        paymentState               = try? map.value("paymentState")
        shippingInfo               = try? map.value("shippingInfo")
        syncInfo                   = try map.value("syncInfo")
        returnInfo                 = try map.value("returnInfo")
        discountCodes              = try map.value("discountCodes")
        lastMessageSequenceNumber  = try map.value("lastMessageSequenceNumber")
        cart                       = try? map.value("cart")
        custom                     = try? map.value("custom")
        paymentInfo                = try? map.value("paymentInfo")
        locale                     = try? map.value("locale")
        inventoryMode              = try map.value("inventoryMode")
    }
}

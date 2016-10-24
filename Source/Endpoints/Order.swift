//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

/**
    Provides complete set of interactions for querying, retrieving and creating an order.
*/
open class Order: QueryEndpoint, ByIdEndpoint, CreateEndpoint, Mappable {
    
    public typealias ResponseType = Order
    public typealias RequestDraft = OrderDraft

    open static let path = "me/orders"

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var completedAt: Date?
    public var orderNumber: String?
    public var customerId: String?
    public var customerEmail: String?
    public var anonymousId: String?
    public var lineItems: [LineItem]?
    public var customLineItems: [CustomLineItem]?
    public var totalPrice: Money?
    public var taxedPrice: TaxedPrice?
    public var shippingAddress: Address?
    public var billingAddress: Address?
    public var taxMode: TaxMode?
    public var customerGroup: Reference<CustomerGroup>?
    public var country: String?
    public var orderState: OrderState?
    public var state: Reference<State>?
    public var shipmentState: ShipmentState?
    public var paymentState: PaymentState?
    public var shippingInfo: ShippingInfo?
    public var syncInfo: [SyncInfo]?
    public var returnInfo: [ReturnInfo]?
    public var discountCodes: [DiscountCodeInfo]?
    public var lastMessageSequenceNumber: Int?
    public var cart: Reference<Cart>?
    public var custom: [String: Any]?
    public var paymentInfo: PaymentInfo?
    public var locale: String?
    public var inventoryMode: InventoryMode?

    public required init?(map: Map) {}

    // MARK: - Mappable

    public func mapping(map: Map) {
        id                         <- map["id"]
        version                    <- map["version"]
        createdAt                  <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt             <- (map["lastModifiedAt"], ISO8601DateTransform())
        completedAt                <- (map["completedAt"], ISO8601DateTransform())
        orderNumber                <- map["orderNumber"]
        customerId                 <- map["customerId"]
        customerEmail              <- map["customerEmail"]
        anonymousId                <- map["anonymousId"]
        lineItems                  <- map["lineItems"]
        customLineItems            <- map["customLineItems"]
        totalPrice                 <- map["totalPrice"]
        taxedPrice                 <- map["taxedPrice"]
        shippingAddress            <- map["shippingAddress"]
        billingAddress             <- map["billingAddress"]
        taxMode                    <- map["taxMode"]
        customerGroup              <- map["customerGroup"]
        country                    <- map["country"]
        orderState                 <- map["orderState"]
        state                      <- map["state"]
        shipmentState              <- map["shipmentState"]
        paymentState               <- map["paymentState"]
        shippingInfo               <- map["shippingInfo"]
        syncInfo                   <- map["syncInfo"]
        returnInfo                 <- map["returnInfo"]
        discountCodes              <- map["discountCodes"]
        lastMessageSequenceNumber  <- map["lastMessageSequenceNumber"]
        cart                       <- map["cart"]
        custom                     <- map["custom"]
        paymentInfo                <- map["paymentInfo"]
        locale                     <- map["locale"]
        inventoryMode              <- map["inventoryMode"]
    }
}

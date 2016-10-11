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

    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var completedAt: Date?
    var orderNumber: String?
    var customerId: String?
    var customerEmail: String?
    var anonymousId: String?
    var lineItems: [LineItem]?
    var customLineItems: [CustomLineItem]?
    var totalPrice: Money?
    var taxedPrice: TaxedPrice?
    var shippingAddress: Address?
    var billingAddress: Address?
    var taxMode: TaxMode?
    var customerGroup: Reference<CustomerGroup>?
    var country: String?
    var orderState: OrderState?
    var state: Reference<State>?
    var shipmentState: ShipmentState?
    var paymentState: PaymentState?
    var shippingInfo: ShippingInfo?
    var syncInfo: [SyncInfo]?
    var returnInfo: [ReturnInfo]?
    var discountCodes: [DiscountCodeInfo]?
    var lastMessageSequenceNumber: Int?
    var cart: Reference<Cart>?
    var custom: [String: Any]?
    var paymentInfo: PaymentInfo?
    var locale: String?
    var inventoryMode: InventoryMode?

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

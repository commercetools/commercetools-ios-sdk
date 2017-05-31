//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

/**
    Provides complete set of interactions for querying, retrieving, creating and updating shopping cart.
*/
open class Cart: QueryEndpoint, ByIdEndpoint, CreateEndpoint, UpdateEndpoint, DeleteEndpoint, Mappable {
    
    public typealias ResponseType = Cart
    public typealias RequestDraft = CartDraft
    public typealias UpdateAction = CartUpdateAction

    open static let path = "me/carts"

    /**
     Retrieves the cart with state Active which has the most recent lastModifiedAt.
     
         - parameter expansion:                An optional array of expansion property names.
         - parameter result:                   The code to be executed after processing the response, providing model
                                               instance in case of a successful result.
     */
    open static func active(expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        return ActiveCart.get(expansion: expansion, result: result)
    }

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var customerId: String?
    public var customerEmail: String?
    public var anonymousId: String?
    public var lineItems: [LineItem]?
    public var customLineItems: [CustomLineItem]?
    public var totalPrice: Money?
    public var taxedPrice: TaxedPrice?
    public var cartState: CartState?
    public var shippingAddress: Address?
    public var billingAddress: Address?
    public var inventoryMode: InventoryMode?
    public var taxMode: TaxMode?
    public var taxRoundingMode: RoundingMode?
    public var customerGroup: Reference<CustomerGroup>?
    public var country: String?
    public var shippingInfo: ShippingInfo?
    public var discountCodes: [DiscountCodeInfo]?
    public var refusedGifts: [Reference<CartDiscount>]?
    public var custom: [String: Any]?
    public var paymentInfo: PaymentInfo?
    public var locale: String?
    public var deleteDaysAfterLastModification: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?

    public required init?(map: Map) {}

    // MARK: - Mappable

    public func mapping(map: Map) {
        id                                  <- map["id"]
        version                             <- map["version"]
        customerId                          <- map["customerId"]
        customerEmail                       <- map["customerEmail"]
        anonymousId                         <- map["anonymousId"]
        lineItems                           <- map["lineItems"]
        customLineItems                     <- map["customLineItems"]
        totalPrice                          <- map["totalPrice"]
        taxedPrice                          <- map["taxedPrice"]
        cartState                           <- map["cartState"]
        shippingAddress                     <- map["shippingAddress"]
        billingAddress                      <- map["billingAddress"]
        inventoryMode                       <- map["inventoryMode"]
        taxMode                             <- map["taxMode"]
        taxRoundingMode                     <- map["taxRoundingMode"]
        customerGroup                       <- map["customerGroup"]
        country                             <- map["country"]
        shippingInfo                        <- map["shippingInfo"]
        discountCodes                       <- map["discountCodes"]
        refusedGifts                        <- map["refusedGifts"]
        custom                              <- map["custom"]
        paymentInfo                         <- map["paymentInfo"]
        locale                              <- map["locale"]
        deleteDaysAfterLastModification     <- map["deleteDaysAfterLastModification"]
        createdAt                           <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt                      <- (map["lastModifiedAt"], ISO8601DateTransform())
    }
}
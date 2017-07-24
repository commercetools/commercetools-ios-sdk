//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import ObjectMapper

/**
    Provides complete set of interactions for querying, retrieving, creating and updating shopping cart.
*/
open class Cart: QueryEndpoint, ByIdEndpoint, CreateEndpoint, UpdateEndpoint, DeleteEndpoint, ImmutableMappable {
    
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

    public let id: String
    public let version: UInt
    public let customerId: String?
    public let customerEmail: String?
    public let anonymousId: String?
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
    public let custom: [String: Any]?
    public let paymentInfo: PaymentInfo?
    public let locale: String?
    public let deleteDaysAfterLastModification: UInt?
    public let createdAt: Date
    public let lastModifiedAt: Date

    public required init(map: Map) throws {
        id                                  = try map.value("id")
        version                             = try map.value("version")
        customerId                          = try? map.value("customerId")
        customerEmail                       = try? map.value("customerEmail")
        anonymousId                         = try? map.value("anonymousId")
        lineItems                           = try map.value("lineItems")
        customLineItems                     = try map.value("customLineItems")
        totalPrice                          = try map.value("totalPrice")
        taxedPrice                          = try? map.value("taxedPrice")
        cartState                           = try map.value("cartState")
        shippingAddress                     = try? map.value("shippingAddress")
        billingAddress                      = try? map.value("billingAddress")
        inventoryMode                       = try map.value("inventoryMode")
        taxMode                             = try map.value("taxMode")
        taxRoundingMode                     = try map.value("taxRoundingMode")
        customerGroup                       = try? map.value("customerGroup")
        country                             = try? map.value("country")
        shippingInfo                        = try? map.value("shippingInfo")
        discountCodes                       = try map.value("discountCodes")
        refusedGifts                        = try map.value("refusedGifts")
        custom                              = try? map.value("custom")
        paymentInfo                         = try? map.value("paymentInfo")
        locale                              = try? map.value("locale")
        deleteDaysAfterLastModification     = try? map.value("deleteDaysAfterLastModification")
        createdAt                           = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt                      = try map.value("lastModifiedAt", using: ISO8601DateTransform())
    }
}
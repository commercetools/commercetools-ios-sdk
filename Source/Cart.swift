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

    /**
     Retrieves the cart with state Active which has the most recent lastModifiedAt.
     
         - parameter expansion:                An optional array of expansion property names.
         - parameter result:                   The code to be executed after processing the response, providing model
                                               instance in case of a successful result.
     */
    public static func active(expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
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
    public let custom: JsonValue?
    public let paymentInfo: PaymentInfo?
    public let locale: String?
    public let deleteDaysAfterLastModification: UInt?
    public let origin: CartOrigin
    public let createdAt: Date
    public let lastModifiedAt: Date
}

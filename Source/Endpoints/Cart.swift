//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Alamofire
import ObjectMapper

/**
    Provides complete set of interactions for querying, retrieving, creating and updating shopping cart.
*/
open class Cart: QueryEndpoint, ByIdEndpoint, CreateEndpoint, UpdateEndpoint, DeleteEndpoint, Mappable {
    
    public typealias ResponseType = Cart

    open static let path = "me/carts"

    /**
     Retrieves the cart with state Active which has the most recent lastModifiedAt.
     
         - parameter expansion:                An optional array of expansion property names.
         - parameter dictionaryResult:         The code to be executed after processing the response, containing result
                                               in dictionary format in case of a success.
     */
    open static func active(expansion: [String]? = nil, dictionaryResult: @escaping (Result<[String: Any]>) -> Void) {
        return ActiveCart.get(expansion: expansion, dictionaryResult: dictionaryResult)
    }

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
    
    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var customerId: String?
    var customerEmail: String?
    var anonymousId: String?
    var lineItems: [LineItem]?
    var customLineItems: [CustomLineItem]?
    var totalPrice: Money?
    var taxedPrice: TaxedPrice?
    var cartState: CartState?
    var shippingAddress: Address?
    var billingAddress: Address?
    var inventoryMode: InventoryMode?
    var taxMode: TaxMode?
    var customerGroup: Reference<CustomerGroup>?
    var country: String?
    var shippingInfo: ShippingInfo?
    var discountCodes: [DiscountCodeInfo]?
    var custom: [String: Any]?
    var paymentInfo: PaymentInfo?
    var locale: String?
    
    public required init?(map: Map) {}
    
    // MARK: - Mappable
    
    public func mapping(map: Map) {
        id               <- map["id"]
        version          <- map["version"]
        createdAt        <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt   <- (map["lastModifiedAt"], ISO8601DateTransform())
        customerId       <- map["customerId"]
        customerEmail    <- map["customerEmail"]
        anonymousId      <- map["anonymousId"]
        lineItems        <- map["lineItems"]
        customLineItems  <- map["customLineItems"]
        totalPrice       <- map["totalPrice"]
        taxedPrice       <- map["taxedPrice"]
        cartState        <- map["cartState"]
        shippingAddress  <- map["shippingAddress"]
        billingAddress   <- map["billingAddress"]
        inventoryMode    <- map["inventoryMode"]
        taxMode          <- map["taxMode"]
        customerGroup    <- map["customerGroup"]
        country          <- map["country"]
        shippingInfo     <- map["shippingInfo"]
        custom           <- map["custom"]
        paymentInfo      <- map["paymentInfo"]
        locale           <- map["locale"]
    }

}

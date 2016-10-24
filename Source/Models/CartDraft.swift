//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct CartDraft: Mappable {

    // MARK: - Properties

    public var currency: String?
    public var customerId: String?
    public var customerEmail: String?
    public var anonymousId: String?
    public var country: String?
    public var inventoryMode: InventoryMode?
    public var taxMode: TaxMode?
    public var lineItems: [LineItemDraft]?
    public var customLineItems: [CustomLineItemDraft]?
    public var shippingAddress: Address?
    public var billingAddress: Address?
    public var shippingMethod: Reference<ShippingMethod>?
    public var externalTaxRateForShippingMethod: ExternalTaxRateDraft?
    public var custom: [String: Any]?
    public var locale: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        currency                          <- map["currency"]
        customerId                        <- map["customerId"]
        customerEmail                     <- map["customerEmail"]
        anonymousId                       <- map["anonymousId"]
        country                           <- map["country"]
        inventoryMode                     <- map["inventoryMode"]
        taxMode                           <- map["taxMode"]
        lineItems                         <- map["lineItems"]
        customLineItems                   <- map["customLineItems"]
        shippingAddress                   <- map["shippingAddress"]
        billingAddress                    <- map["billingAddress"]
        shippingMethod                    <- map["shippingMethod"]
        externalTaxRateForShippingMethod  <- map["externalTaxRateForShippingMethod"]
        custom                            <- map["custom"]
        locale                            <- map["locale"]
    }

}

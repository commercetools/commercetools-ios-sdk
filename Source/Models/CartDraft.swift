//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct CartDraft: Mappable {

    // MARK: - Properties

    var currency: String?
    var customerId: String?
    var customerEmail: String?
    var anonymousId: String?
    var country: String?
    var inventoryMode: InventoryMode?
    var taxMode: TaxMode?
    var lineItems: [LineItemDraft]?
    var customLineItems: [CustomLineItemDraft]?
    var shippingAddress: Address?
    var billingAddress: Address?
    var shippingMethod: Reference<ShippingMethod>?
    var externalTaxRateForShippingMethod: ExternalTaxRateDraft?
    var custom: [String: Any]?
    var locale: String?

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

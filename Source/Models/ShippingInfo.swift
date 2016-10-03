//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper
struct ShippingInfo: Mappable {
    
    // MARK: - Properties
    
    var shippingMethodName: String?
    var price: Money?
    var shippingRate: ShippingRate?
    var taxedPrice: TaxedItemPrice?
    var taxRate: TaxRate?
    var taxCategory: Reference<TaxCategory>?
    var shippingMethod: Reference<ShippingMethod>?
    var deliveries: [Delivery]?
    var discountedPrice: DiscountedLineItemPrice?

    init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating func mapping(map: Map) {
        shippingMethodName         <- map["shippingMethodName"]
        price                      <- map["price"]
        shippingRate               <- map["shippingRate"]
        taxedPrice                 <- map["taxedPrice"]
        taxRate                    <- map["taxRate"]
        taxCategory                <- map["taxCategory"]
        shippingMethod             <- map["shippingMethod"]
        deliveries                 <- map["deliveries"]
        discountedPrice            <- map["discountedPrice"]
    }
    
}

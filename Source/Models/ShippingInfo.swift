//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper
public struct ShippingInfo: Mappable {
    
    // MARK: - Properties
    
    public var shippingMethodName: String?
    public var price: Money?
    public var shippingRate: ShippingRate?
    public var taxedPrice: TaxedItemPrice?
    public var taxRate: TaxRate?
    public var taxCategory: Reference<TaxCategory>?
    public var shippingMethod: Reference<ShippingMethod>?
    public var deliveries: [Delivery]?
    public var discountedPrice: DiscountedLineItemPrice?

    public init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating public func mapping(map: Map) {
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

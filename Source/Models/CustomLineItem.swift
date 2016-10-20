//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct CustomLineItem: Mappable {
    
    // MARK: - Properties
    
    public var id: String?
    public var name: LocalizedString?
    public var money: Money?
    public var taxedPrice: TaxedItemPrice?
    public var totalPrice: Money?
    public var slug: String?
    public var quantity: Int?
    public var state: ItemState?
    public var taxCategory: Reference<TaxCategory>?
    public var taxRate: TaxRate?
    public var discountedPricePerQuantity: [DiscountedLineItemPriceForQuantity]?
    public var custom: [String: Any]?    
    
    public init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating public func mapping(map: Map) {
        id                          <- map["id"]
        name                        <- map["name"]
        money                       <- map["money"]
        taxedPrice                  <- map["taxedPrice"]
        totalPrice                  <- map["totalPrice"]
        slug                        <- map["slug"]
        quantity                    <- map["quantity"]
        state                       <- map["state"]
        taxCategory                 <- map["taxCategory"]
        taxRate                     <- map["taxRate"]
        discountedPricePerQuantity  <- map["discountedPricePerQuantity"]
        custom                      <- map["custom"]
    }
    
}

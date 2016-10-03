//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct CustomLineItem: Mappable {
    
    // MARK: - Properties
    
    var id: String?
    var name: LocalizedString?
    var money: Money?
    var taxedPrice: TaxedItemPrice?
    var totalPrice: Money?
    var slug: String?
    var quantity: Int?
    var state: ItemState?
    var taxCategory: Reference<TaxCategory>?
    var taxRate: TaxRate?
    var discountedPricePerQuantity: [DiscountedLineItemPriceForQuantity]?
    var custom: [String: Any]?    
    
    init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating func mapping(map: Map) {
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

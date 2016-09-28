//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct LineItem: Mappable {
    
    // MARK: - Properties
    
    var id: String?
    var productId: String?
    var name: [String: String]?
    var productSlug: [String: String]?
    var variant: ProductVariant?
    var price: Price?
    var totalPrice: Money?
    var discountedPricePerQuantity: [DiscountedLineItemPriceForQuantity]?
    var quantity: Int?
    var distributionChannel: Channel?
    
    init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating func mapping(map: Map) {
        id                         <- map["id"]
        productId                  <- map["productId"]
        name                       <- map["name"]
        productSlug                <- map["productSlug"]
        variant                    <- map["variant"]
        price                      <- map["price"]
        totalPrice                 <- map["totalPrice"]
        discountedPricePerQuantity <- map["discountedPricePerQuantity"]
        quantity                   <- map["quantity"]
        distributionChannel        <- map["distributionChannel.obj"]
    }
    
}

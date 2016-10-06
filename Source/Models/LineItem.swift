//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public typealias LocalizedString = [String: String]

public struct LineItem: Mappable {
    
    // MARK: - Properties
    
    var id: String?
    var productId: String?
    var name: LocalizedString?
    var productSlug: LocalizedString?
    var variant: ProductVariant?
    var price: Price?
    var taxedPrice: TaxedItemPrice?
    var totalPrice: Money?
    var quantity: Int?
    var state: [ItemState]?
    var taxRate: TaxRate?
    var supplyChannel: Reference<Channel>?
    var distributionChannel: Reference<Channel>?
    var discountedPricePerQuantity: [DiscountedLineItemPriceForQuantity]?
    var priceMode: LineItemPriceMode?
    var custom: [String: Any]?
    
    public init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating public func mapping(map: Map) {
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

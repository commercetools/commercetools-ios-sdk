//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public typealias LocalizedString = [String: String]

public struct LineItem: Mappable {
    
    // MARK: - Properties
    
    public var id: String?
    public var productId: String?
    public var name: LocalizedString?
    public var productSlug: LocalizedString?
    public var variant: ProductVariant?
    public var price: Price?
    public var taxedPrice: TaxedItemPrice?
    public var totalPrice: Money?
    public var quantity: Int?
    public var state: [ItemState]?
    public var taxRate: TaxRate?
    public var supplyChannel: Reference<Channel>?
    public var distributionChannel: Reference<Channel>?
    public var discountedPricePerQuantity: [DiscountedLineItemPriceForQuantity]?
    public var priceMode: LineItemPriceMode?
    public var custom: [String: Any]?
    
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
        distributionChannel        <- map["distributionChannel"]
    }
    
}

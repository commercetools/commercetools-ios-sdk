//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ProductVariant: Mappable {

    // MARK: - Properties

    public var id: Int?
    public var sku: String?
    public var key: String?
    public var prices: [Price]?
    public var attributes: [Attribute]?
    public var price: Price?
    public var images: [Image]?
    public var assets: [Asset]?
    public var availability: ProductVariantAvailability?
    public var isMatchingVariant: Bool?
    public var scopedPrice: ScopedPrice?
    public var scopedPriceDiscounted: Bool?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                     <- map["id"]
        sku                    <- map["sku"]
        key                    <- map["key"]
        prices                 <- map["prices"]
        attributes             <- map["attributes"]
        price                  <- map["price"]
        images                 <- map["images"]
        assets                 <- map["assets"]
        availability           <- map["availability"]
        isMatchingVariant      <- map["isMatchingVariant"]
        scopedPrice            <- map["scopedPrice"]
        scopedPriceDiscounted  <- map["scopedPriceDiscounted"]
    }
}

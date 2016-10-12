//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ProductVariant: Mappable {

    // MARK: - Properties

    var id: Int?
    var sku: String?
    var key: String?
    var prices: [Price]?
    var attributes: [Attribute]?
    var price: Price?
    var images: [Image]?
    var assets: [Asset]?
    var availability: ProductVariantAvailability?
    var isMatchingVariant: Bool?
    var scopedPrice: ScopedPrice?
    var scopedPriceDiscounted: Bool?

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

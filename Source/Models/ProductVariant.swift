//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ProductVariant: Mappable {

    // MARK: - Properties

    var id: Int?
    var sku: String?
    var prices: [Price]?
    var attributes: [Attribute]?
    var images: [Image]?
    var availability: ProductVariantAvailability?
    var isMatchingVariant: Bool?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                 <- map["id"]
        sku                <- map["sku"]
        prices             <- map["prices"]
        attributes         <- map["attributes"]
        images             <- map["images"]
        availability       <- map["availability"]
        isMatchingVariant  <- map["isMatchingVariant"]
    }

}

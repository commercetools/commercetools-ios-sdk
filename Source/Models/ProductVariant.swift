//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct ProductVariant: Mappable {

    // MARK: - Properties

    var id: Int?
    var sku: String?
    var prices: [Price]?
    var attributes: [Attribute]?
    var images: [Image]?
    var availability: ProductVariantAvailability?
    var isMatchingVariant: Bool?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        id                 <- map["id"]
        sku                <- map["sku"]
        prices             <- map["prices"]
        attributes         <- map["attributes"]
        images             <- map["images"]
        availability       <- map["availability"]
        isMatchingVariant  <- map["isMatchingVariant"]
    }

}

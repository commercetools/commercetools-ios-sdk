//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct ProductVariantAvailability: Mappable {

    // MARK: - Properties

    var isOnStock: Bool?
    var restockableInDays: Int?
    var availableQuantity: Int?
    var channels: [String: ProductVariantAvailability]?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        isOnStock                <- map["isOnStock"]
        restockableInDays        <- map["restockableInDays"]
        availableQuantity        <- map["availableQuantity"]
        channels                 <- map["channels"]
    }



}

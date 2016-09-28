//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct DiscountedLineItemPriceForQuantity: Mappable {

    // MARK: - Properties

    var quantity: Int?
    var discountedPrice: DiscountedLineItemPrice?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        quantity         <- map["quantity"]
        discountedPrice  <- map["discountedPrice"]
    }

}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct CartDiscountValue: Mappable {

    // MARK: - Properties

    var type: String?
    var permyriad: Int?
    var money: Money?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        type          <- map["type"]
        permyriad     <- map["permyriad"]
        money         <- map["money"]
    }

}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct PaymentInfo: Mappable {

    // MARK: - Properties

    var payments: [Reference<Payment>]?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        payments           <- map["payments"]
    }

}

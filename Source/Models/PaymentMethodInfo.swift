//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct PaymentMethodInfo: Mappable {

    // MARK: - Properties

    var paymentInterface: String?
    var method: String?
    var name: LocalizedString?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        paymentInterface      <- map["paymentInterface"]
        method                <- map["method"]
        name                  <- map["name"]
    }

}

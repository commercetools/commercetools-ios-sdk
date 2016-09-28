//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct Money: Mappable {

    // MARK: - Properties

    var currencyCode: String?
    var centAmount: Int?

    init?(map: Map) {}

    init(currencyCode: String? = nil, centAmount: Int? = nil) {
        self.currencyCode = currencyCode
        self.centAmount = centAmount
    }

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        currencyCode       <- map["currencyCode"]
        centAmount         <- map["centAmount"]
    }
}

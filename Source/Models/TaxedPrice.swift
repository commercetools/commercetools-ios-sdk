//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct TaxedPrice: Mappable {

    // MARK: - Properties

    var totalNet: Money?
    var totalGross: Money?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        totalNet         <- map["totalNet"]
        totalGross       <- map["totalGross"]
    }

}

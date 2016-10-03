//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct SubRate: Mappable {

    // MARK: - Properties

    var name: String?
    var amount: Double?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        name       <- map["name"]
        amount     <- map["amount"]
    }

}

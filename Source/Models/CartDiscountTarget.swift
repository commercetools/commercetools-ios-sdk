//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct CartDiscountTarget: Mappable {

    // MARK: - Properties

    var type: String?
    var predicate: String?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        type          <- map["type"]
        predicate     <- map["predicate"]
    }

}

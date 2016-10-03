//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct ItemState: Mappable {

    // MARK: - Properties

    var quantity: Int?
    var state: Reference<State>?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        quantity                <- map["quantity"]
        state                   <- map["state"]
    }

}

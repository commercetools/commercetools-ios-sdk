//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct DeliveryItem: Mappable {

    // MARK: - Properties

    var id: String?
    var quantity: Int?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        id                <- map["id"]
        quantity          <- map["quantity"]
    }

}

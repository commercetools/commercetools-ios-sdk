//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct DeliveryItem: Mappable {

    // MARK: - Properties

    var id: String?
    var quantity: Int?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        quantity          <- map["quantity"]
    }

}

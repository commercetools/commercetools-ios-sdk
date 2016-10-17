//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ExternalLineItemTotalPrice: Mappable {

    // MARK: - Properties

    var price: Money?
    var totalPrice: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        price              <- map["price"]
        totalPrice         <- map["totalPrice"]
    }
}
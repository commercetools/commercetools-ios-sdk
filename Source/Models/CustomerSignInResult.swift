//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct CustomerSignInResult: Mappable {

    // MARK: - Properties

    var customer: Customer?
    var cart: Cart?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        customer         <- map["customer"]
        cart             <- map["cart"]
    }
}

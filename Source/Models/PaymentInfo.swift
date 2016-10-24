//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct PaymentInfo: Mappable {

    // MARK: - Properties

    public var payments: [Reference<Payment>]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        payments           <- map["payments"]
    }

}

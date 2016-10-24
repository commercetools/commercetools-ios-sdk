//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct PaymentMethodInfo: Mappable {

    // MARK: - Properties

    public var paymentInterface: String?
    public var method: String?
    public var name: LocalizedString?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        paymentInterface      <- map["paymentInterface"]
        method                <- map["method"]
        name                  <- map["name"]
    }

}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct PaymentStatus: Mappable {

    // MARK: - Properties

    var interfaceCode: String?
    var interfaceText: String?
    var state: Reference<State>?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        interfaceCode      <- map["interfaceCode"]
        interfaceText      <- map["interfaceText"]
        state              <- map["state"]
    }

}

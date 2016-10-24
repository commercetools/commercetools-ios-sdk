//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct PaymentStatus: Mappable {

    // MARK: - Properties

    public var interfaceCode: String?
    public var interfaceText: String?
    public var state: Reference<State>?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        interfaceCode      <- map["interfaceCode"]
        interfaceText      <- map["interfaceText"]
        state              <- map["state"]
    }

}

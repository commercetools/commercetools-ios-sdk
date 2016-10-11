//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct SubRate: Mappable {

    // MARK: - Properties

    var name: String?
    var amount: Double?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        name       <- map["name"]
        amount     <- map["amount"]
    }

}

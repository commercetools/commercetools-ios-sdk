//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Money: Mappable {

    // MARK: - Properties

    public var currencyCode: String?
    public var centAmount: Int?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        currencyCode       <- map["currencyCode"]
        centAmount         <- map["centAmount"]
    }
}

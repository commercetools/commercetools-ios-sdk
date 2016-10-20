//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct TaxedItemPrice: Mappable {

    // MARK: - Properties

    public var totalNet: Money?
    public var totalGross: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        totalNet                <- map["totalNet"]
        totalGross              <- map["totalGross"]
    }

}

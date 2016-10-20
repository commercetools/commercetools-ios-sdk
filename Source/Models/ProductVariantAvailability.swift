//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ProductVariantAvailability: Mappable {

    // MARK: - Properties

    public var isOnStock: Bool?
    public var restockableInDays: Int?
    public var availableQuantity: Int?
    public var channels: [String: ProductVariantAvailability]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        isOnStock                <- map["isOnStock"]
        restockableInDays        <- map["restockableInDays"]
        availableQuantity        <- map["availableQuantity"]
        channels                 <- map["channels"]
    }
}

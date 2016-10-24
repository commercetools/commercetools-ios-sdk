//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ParcelMeasurements: Mappable {

    // MARK: - Properties

    public var heightInMillimeter: Double?
    public var lengthInMillimeter: Double?
    public var widthInMillimeter: Double?
    public var weightInGram: Double?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        heightInMillimeter   <- map["heightInMillimeter"]
        lengthInMillimeter   <- map["lengthInMillimeter"]
        widthInMillimeter    <- map["widthInMillimeter"]
        weightInGram         <- map["weightInGram"]
    }

}

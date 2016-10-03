//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct ParcelMeasurements: Mappable {

    // MARK: - Properties

    var heightInMillimeter: Double?
    var lengthInMillimeter: Double?
    var widthInMillimeter: Double?
    var weightInGram: Double?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        heightInMillimeter   <- map["heightInMillimeter"]
        lengthInMillimeter   <- map["lengthInMillimeter"]
        widthInMillimeter    <- map["widthInMillimeter"]
        weightInGram         <- map["weightInGram"]
    }

}

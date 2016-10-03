//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct ReviewRatingStatistics: Mappable {

    // MARK: - Properties

    var averageRating: Double?
    var highestRating: Double?
    var lowestRating: Double?
    var count: UInt?
    var ratingsDistribution: [String: Any]?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        averageRating        <- map["averageRating"]
        highestRating        <- map["highestRating"]
        lowestRating         <- map["lowestRating"]
        count                <- map["count"]
        ratingsDistribution  <- map["ratingsDistribution"]
    }
}

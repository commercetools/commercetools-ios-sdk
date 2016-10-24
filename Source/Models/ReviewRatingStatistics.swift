//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ReviewRatingStatistics: Mappable {

    // MARK: - Properties

    public var averageRating: Double?
    public var highestRating: Double?
    public var lowestRating: Double?
    public var count: UInt?
    public var ratingsDistribution: [String: Any]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        averageRating        <- map["averageRating"]
        highestRating        <- map["highestRating"]
        lowestRating         <- map["lowestRating"]
        count                <- map["count"]
        ratingsDistribution  <- map["ratingsDistribution"]
    }
}

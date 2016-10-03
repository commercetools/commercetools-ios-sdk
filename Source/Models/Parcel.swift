//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct Parcel: Mappable {

    // MARK: - Properties

    var id: String?
    var createdAt: Date?
    var measurements: ParcelMeasurements?
    var trackingData: TrackingData?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        id                <- map["id"]
        createdAt         <- (map["createdAt"], ISO8601DateTransform())
        measurements      <- map["measurements"]
        trackingData      <- map["trackingData"]
    }

}

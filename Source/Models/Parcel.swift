//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Parcel: Mappable {

    // MARK: - Properties

    var id: String?
    var createdAt: Date?
    var measurements: ParcelMeasurements?
    var trackingData: TrackingData?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        createdAt         <- (map["createdAt"], ISO8601DateTransform())
        measurements      <- map["measurements"]
        trackingData      <- map["trackingData"]
    }

}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Parcel: Mappable {

    // MARK: - Properties

    public var id: String?
    public var createdAt: Date?
    public var measurements: ParcelMeasurements?
    public var trackingData: TrackingData?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        createdAt         <- (map["createdAt"], ISO8601DateTransform())
        measurements      <- map["measurements"]
        trackingData      <- map["trackingData"]
    }

}

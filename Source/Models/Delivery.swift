//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Delivery: Mappable {

    // MARK: - Properties

    public var id: String?
    public var createdAt: Date?
    public var items: [DeliveryItem]?
    public var parcels: [Parcel]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        createdAt         <- (map["createdAt"], ISO8601DateTransform())
        items             <- map["items"]
        parcels           <- map["parcels"]
    }

}

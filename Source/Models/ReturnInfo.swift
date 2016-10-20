//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ReturnInfo: Mappable {

    // MARK: - Properties

    public var items: [ReturnItem]?
    public var returnTrackingId: String?
    public var returnDate: Date?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        items              <- map["items"]
        returnTrackingId   <- map["returnTrackingId"]
        returnDate         <- (map["returnDate"], ISO8601DateTransform())
    }
}

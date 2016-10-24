//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct TrackingData: Mappable {

    // MARK: - Properties

    public var trackingId: String?
    public var carrier: String?
    public var provider: String?
    public var providerTransaction: String?
    public var isReturn: Bool?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        trackingId           <- map["trackingId"]
        carrier              <- map["carrier"]
        provider             <- map["provider"]
        providerTransaction  <- map["providerTransaction"]
        isReturn             <- map["isReturn"]
    }

}

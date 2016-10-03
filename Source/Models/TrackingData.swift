//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct TrackingData: Mappable {

    // MARK: - Properties

    var trackingId: String?
    var carrier: String?
    var provider: String?
    var providerTransaction: String?
    var isReturn: Bool?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        trackingId           <- map["trackingId"]
        carrier              <- map["carrier"]
        provider             <- map["provider"]
        providerTransaction  <- map["providerTransaction"]
        isReturn             <- map["isReturn"]
    }

}

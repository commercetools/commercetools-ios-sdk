//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct SyncInfo: Mappable {

    // MARK: - Properties

    public var channel: Reference<Channel>?
    public var externalId: String?
    public var syncedAt: Date?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        channel          <- map["channel"]
        externalId       <- map["externalId"]
        syncedAt         <- (map["syncedAt"], ISO8601DateTransform())
    }
}

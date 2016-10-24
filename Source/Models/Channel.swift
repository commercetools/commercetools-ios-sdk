//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Channel: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var key: String?
    public var roles: [ChannelRole]?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var address: Address?
    public var reviewRatingStatistics: ReviewRatingStatistics?
    public var custom: [String: Any]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                      <- map["id"]
        version                 <- map["version"]
        createdAt               <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt          <- (map["lastModifiedAt"], ISO8601DateTransform())
        key                     <- map["key"]
        roles                   <- map["roles"]
        name                    <- map["name"]
        description             <- map["description"]
        address                 <- map["address"]
        reviewRatingStatistics  <- map["reviewRatingStatistics"]
        custom                  <- map["custom"]
    }

}

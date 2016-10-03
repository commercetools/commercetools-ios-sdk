//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

class Channel: Mappable {

    // MARK: - Properties

    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var key: String?
    var roles: [ChannelRole]?
    var name: LocalizedString?
    var description: LocalizedString?
    var address: Address?
    var reviewRatingStatistics: ReviewRatingStatistics?
    var custom: [String: Any]?

    required init?(map: Map) {}

    // MARK: - Mappable

    func mapping(map: Map) {
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

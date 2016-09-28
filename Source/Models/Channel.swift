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
    var name: [String: String]?
    var description: [String: String]?
    var address: Address?

    required init?(map: Map) {}

    // MARK: - Mappable

    func mapping(map: Map) {
        id               <- map["id"]
        version          <- map["version"]
        createdAt        <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt   <- (map["lastModifiedAt"], ISO8601DateTransform())
        key              <- map["key"]
        name             <- map["name"]
        description      <- map["description"]
        address          <- map["address"]
    }

}

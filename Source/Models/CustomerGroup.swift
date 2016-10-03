//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct CustomerGroup: Mappable {
    
    // MARK: - Properties
    
    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var name: String?
    
    init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating func mapping(map: Map) {
        id               <- map["id"]
        version          <- map["version"]
        createdAt        <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt   <- (map["lastModifiedAt"], ISO8601DateTransform())
        name             <- map["name"]
    }
    
}

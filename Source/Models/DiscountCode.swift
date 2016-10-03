//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct DiscountCode: Mappable {
    
    // MARK: - Properties
    
    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var name: LocalizedString?
    var description: LocalizedString?
    var code: String?
    var cartDiscounts: [CartDiscount]?
    var cartPredicate: String?
    var isActive: Bool?
    var references: [GenericReference]?
    var maxApplications: Int?
    var maxApplicationsPerCustomer: Int?
    
    init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating func mapping(map: Map) {
        id                           <- map["id"]
        version                      <- map["version"]
        createdAt                    <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt               <- (map["lastModifiedAt"], ISO8601DateTransform())
        name                         <- map["name"]
        description                  <- map["description"]
        code                         <- map["code"]
        cartDiscounts                <- map["cartDiscounts"]
        cartPredicate                <- map["cartPredicate"]
        isActive                     <- map["isActive"]
        references                   <- map["references"]
        maxApplications              <- map["maxApplications"]
        maxApplicationsPerCustomer   <- map["maxApplicationsPerCustomer"]
    }
    
}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct DiscountCode: Mappable {
    
    // MARK: - Properties
    
    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var code: String?
    public var cartDiscounts: [CartDiscount]?
    public var cartPredicate: String?
    public var isActive: Bool?
    public var references: [GenericReference]?
    public var maxApplications: Int?
    public var maxApplicationsPerCustomer: Int?
    
    public init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating public func mapping(map: Map) {
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

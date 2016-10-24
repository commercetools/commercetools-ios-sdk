//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct CustomerDraft: Mappable {

    // MARK: - Properties

    public var email: String?
    public var password: String?
    public var firstName: String?
    public var lastName: String?
    public var middleName: String?
    public var title: String?
    public var dateOfBirth: Date?
    public var companyName: String?
    public var vatId: String?
    public var addresses: [Address]?
    public var defaultBillingAddress: Int?
    public var defaultShippingAddress: Int?
    public var custom: [String: Any]?
    public var locale: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        email                     <- map["email"]
        password                  <- map["password"]
        firstName                 <- map["firstName"]
        lastName                  <- map["lastName"]
        middleName                <- map["middleName"]
        title                     <- map["title"]
        dateOfBirth               <- (map["dateOfBirth"], ISO8601DateTransform())
        companyName               <- map["companyName"]
        vatId                     <- map["vatId"]
        addresses                 <- map["addresses"]
        defaultBillingAddress     <- map["defaultBillingAddress"]
        defaultShippingAddress    <- map["defaultShippingAddress"]
        custom                    <- map["custom"]
        locale                    <- map["locale"]
    }
}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct CustomerDraft: Mappable {

    // MARK: - Properties

    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var title: String?
    var dateOfBirth: Date?
    var companyName: String?
    var vatId: String?
    var addresses: [Address]?
    var defaultBillingAddress: Int?
    var defaultShippingAddress: Int?
    var custom: [String: Any]?
    var locale: String?

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

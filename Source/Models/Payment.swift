//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct Payment: Mappable {

    // MARK: - Properties

    var id: String?
    var version: UInt?
    var customer: Reference<Customer>?
    var externalId: String?
    var interfaceId: String?
    var amountPlanned: Money?
    var amountAuthorized: Money?
    var authorizedUntil: String?
    var amountPaid: Money?
    var amountRefunded: Money?
    var paymentMethodInfo: PaymentMethodInfo?
    var paymentStatus: PaymentStatus?
    var transactions: [Transaction]?
    var interfaceInteractions: [[String: Any]]?
    var custom: [String: Any]?
    var createdAt: Date?
    var lastModifiedAt: Date?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        id                    <- map["id"]
        version               <- map["version"]
        customer              <- map["customer"]
        externalId            <- map["externalId"]
        interfaceId           <- map["interfaceId"]
        amountPlanned         <- map["amountPlanned"]
        amountAuthorized      <- map["amountAuthorized"]
        authorizedUntil       <- map["authorizedUntil"]
        amountPaid            <- map["amountPaid"]
        amountRefunded        <- map["amountRefunded"]
        paymentMethodInfo     <- map["paymentMethodInfo"]
        paymentStatus         <- map["paymentStatus"]
        transactions          <- map["transactions"]
        interfaceInteractions <- map["interfaceInteractions"]
        custom                <- map["custom"]
        createdAt             <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt        <- (map["lastModifiedAt"], ISO8601DateTransform())
    }

}

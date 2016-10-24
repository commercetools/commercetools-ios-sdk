//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Payment: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var customer: Reference<Customer>?
    public var externalId: String?
    public var interfaceId: String?
    public var amountPlanned: Money?
    public var amountAuthorized: Money?
    public var authorizedUntil: String?
    public var amountPaid: Money?
    public var amountRefunded: Money?
    public var paymentMethodInfo: PaymentMethodInfo?
    public var paymentStatus: PaymentStatus?
    public var transactions: [Transaction]?
    public var interfaceInteractions: [[String: Any]]?
    public var custom: [String: Any]?
    public var createdAt: Date?
    public var lastModifiedAt: Date?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
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

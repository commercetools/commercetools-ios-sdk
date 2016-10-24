//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ReturnItem: Mappable {

    // MARK: - Properties

    public var id: String?
    public var quantity: UInt?
    public var lineItemId: String?
    public var comment: String?
    public var shipmentState: ReturnShipmentState?
    public var paymentState: ReturnPaymentState?
    public var lastModifiedAt: Date?
    public var createdAt: Date?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id             <- map["id"]
        quantity       <- map["quantity"]
        lineItemId     <- map["lineItemId"]
        comment        <- map["comment"]
        shipmentState  <- map["shipmentState"]
        paymentState   <- map["paymentState"]
        lastModifiedAt <- (map["lastModifiedAt"], ISO8601DateTransform())
        createdAt      <- (map["createdAt"], ISO8601DateTransform())
    }
}

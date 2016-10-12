//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct ReturnItem: Mappable {

    // MARK: - Properties

    var id: String?
    var quantity: UInt?
    var lineItemId: String?
    var comment: String?
    var shipmentState: ReturnShipmentState?
    var paymentState: ReturnPaymentState?
    var lastModifiedAt: Date?
    var createdAt: Date?

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

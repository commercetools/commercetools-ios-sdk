//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Transaction: Mappable {

    // MARK: - Properties

    public var id: String?
    public var timestamp: Date?
    public var type: TransactionType?
    public var amount: Money?
    public var interactionId: String?
    public var state: TransactionState?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                    <- map["id"]
        timestamp             <- map["timestamp"]
        type                  <- map["type"]
        amount                <- map["amount"]
        interactionId         <- map["interactionId"]
        state                 <- map["state"]
    }

}

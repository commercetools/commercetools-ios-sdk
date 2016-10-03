//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct Transaction: Mappable {

    // MARK: - Properties

    var id: String?
    var timestamp: Date?
    var type: TransactionType?
    var amount: Money?
    var interactionId: String?
    var state: TransactionState?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        id                    <- map["id"]
        timestamp             <- map["timestamp"]
        type                  <- map["type"]
        amount                <- map["amount"]
        interactionId         <- map["interactionId"]
        state                 <- map["state"]
    }

}

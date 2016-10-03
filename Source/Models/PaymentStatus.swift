//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct PaymentStatus: Mappable {

    // MARK: - Properties

    var interfaceCode: String?
    var interfaceText: String?
    var state: Reference<State>?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        interfaceCode      <- map["interfaceCode"]
        interfaceText      <- map["interfaceText"]
        state              <- map["state"]
    }

}

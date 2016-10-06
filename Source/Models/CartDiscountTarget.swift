//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct CartDiscountTarget: Mappable {

    // MARK: - Properties

    var type: String?
    var predicate: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        type          <- map["type"]
        predicate     <- map["predicate"]
    }

}

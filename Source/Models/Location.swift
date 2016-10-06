//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Location: Mappable {

    // MARK: - Properties

    var country: String?
    var state: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        country           <- map["country"]
        state             <- map["state"]
    }

}

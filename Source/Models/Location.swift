//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct Location: Mappable {

    // MARK: - Properties

    var country: String?
    var state: String?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        country           <- map["country"]
        state             <- map["state"]
    }

}

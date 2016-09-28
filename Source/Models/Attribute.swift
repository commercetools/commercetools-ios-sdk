//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct Attribute: Mappable {

    // MARK: - Properties

    var name: String?
    var value: AnyObject?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        name               <- map["name"]
        value              <- map["value"]
    }

}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct Image: Mappable {

    // MARK: - Properties

    var url: String?
    var dimensions: [String: Int]?
    var label: String?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        url                <- map["url"]
        dimensions         <- map["dimensions"]
        label              <- map["label"]
    }

}

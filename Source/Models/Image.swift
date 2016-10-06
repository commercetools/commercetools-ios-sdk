//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Image: Mappable {

    // MARK: - Properties

    var url: String?
    var dimensions: [String: Int]?
    var label: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        url                <- map["url"]
        dimensions         <- map["dimensions"]
        label              <- map["label"]
    }

}

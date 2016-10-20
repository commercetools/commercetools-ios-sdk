//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Image: Mappable {

    // MARK: - Properties

    public var url: String?
    public var dimensions: [String: Int]?
    public var label: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        url                <- map["url"]
        dimensions         <- map["dimensions"]
        label              <- map["label"]
    }

}

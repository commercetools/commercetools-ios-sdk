//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public class AttributeType: Mappable {

    // MARK: - Properties

    public var name: String?
    public var elementType: AttributeType?

    required public init?(map: Map) {}

    // MARK: - Mappable

    public func mapping(map: Map) {
        name               <- map["name"]
        elementType        <- map["elementType"]
    }

}

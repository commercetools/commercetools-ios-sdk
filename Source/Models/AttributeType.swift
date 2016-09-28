//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

class AttributeType: Mappable {

    // MARK: - Properties

    var name: String?
    var elementType: AttributeType?

    required init?(map: Map) {}

    // MARK: - Mappable

    func mapping(map: Map) {
        name               <- map["name"]
        elementType        <- map["elementType"]
    }

}

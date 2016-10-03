//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct Reference<T: Mappable>: Mappable {

    // MARK: - Properties

    var id: String?
    var typeId: String?
    var obj: T?

    init?(map: Map) {}

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        id              <- map["id"]
        typeId          <- map["typeId"]
        obj             <- map["obj"]
    }

}

struct GenericReference: Mappable {
    
    // MARK: - Properties
    
    var id: String?
    var typeId: String?
    
    init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        typeId          <- map["typeId"]
    }
    
}

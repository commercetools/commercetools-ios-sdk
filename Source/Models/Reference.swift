//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Reference<T: Mappable>: Mappable {

    // MARK: - Properties

    var id: String?
    var typeId: String?
    var obj: T?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id              <- map["id"]
        typeId          <- map["typeId"]
        obj             <- map["obj"]
    }
}

public struct GenericReference: Mappable {
    
    // MARK: - Properties
    
    var id: String?
    var typeId: String?
    
    public init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating public func mapping(map: Map) {
        id              <- map["id"]
        typeId          <- map["typeId"]
    }
}

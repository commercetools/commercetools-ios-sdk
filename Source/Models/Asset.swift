//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Asset: Mappable {

    // MARK: - Properties

    var id: String?
    var sources: [AssetSource]?
    var name: LocalizedString?
    var description: LocalizedString?
    var tags: [String]?
    var custom: [String: Any]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id               <- map["id"]
        sources          <- map["sources"]
        name             <- map["name"]
        description      <- map["description"]
        tags             <- map["tags"]
        custom           <- map["custom"]
    }
}

public struct AssetSource: Mappable {

    // MARK: - Properties

    var uri: String?
    var key: String?
    var dimensions: [AssetDimensions]?
    var contentType: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        uri              <- map["uri"]
        key              <- map["key"]
        dimensions       <- map["dimensions"]
        contentType      <- map["contentType"]
    }
}

public struct AssetDimensions: Mappable {

    // MARK: - Properties

    var w: Double?
    var h: Double?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        w              <- map["w"]
        h              <- map["h"]
    }
}

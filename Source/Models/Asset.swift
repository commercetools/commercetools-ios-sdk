//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Asset: Mappable {

    // MARK: - Properties

    public var id: String?
    public var sources: [AssetSource]?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var tags: [String]?
    public var custom: [String: Any]?

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

    public var uri: String?
    public var key: String?
    public var dimensions: [AssetDimensions]?
    public var contentType: String?

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

    public var w: Double?
    public var h: Double?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        w              <- map["w"]
        h              <- map["h"]
    }
}

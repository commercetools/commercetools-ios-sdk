//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct SearchKeyword: Mappable {

    // MARK: - Properties

    public var text: String?
    public var suggestTokenizer: SuggestTokenizer?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        text                  <- map["text"]
        suggestTokenizer      <- map["suggestTokenizer"]
    }
}

public struct SuggestTokenizer: Mappable {

    // MARK: - Properties

    public var type: String?
    public var inputs: [String]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        type                  <- map["type"]
        inputs                <- map["inputs"]
    }
}

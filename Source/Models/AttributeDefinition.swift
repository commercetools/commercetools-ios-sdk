//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct AttributeDefinition: Mappable {
    
    // MARK: - Properties

    public var type: AttributeType?
    public var name: String?
    public var label: [String: String]?
    public var inputTip: [String: String]?
    public var isRequired: Bool?
    public var isSearchable: Bool?
    
    public init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating public func mapping(map: Map) {
        type               <- map["type"]
        name               <- map["name"]
        label              <- map["label"]
        inputTip           <- map["inputTip"]
        isRequired         <- map["isRequired"]
        isSearchable       <- map["isSearchable"]
    }
    
}

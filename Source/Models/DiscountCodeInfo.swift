//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct DiscountCodeInfo: Mappable {
    
    // MARK: - Properties
    
    public var discountCode: Reference<DiscountCode>?
    public var state: DiscountCodeState?
    
    public init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating public func mapping(map: Map) {
        discountCode           <- map["discountCode"]
        state                  <- map["state"]
    }
    
}

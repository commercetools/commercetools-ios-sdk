//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

struct DiscountCodeInfo: Mappable {
    
    // MARK: - Properties
    
    var discountCode: Reference<DiscountCode>?
    var state: DiscountCodeState?
    
    init?(map: Map) {}
    
    // MARK: - Mappable
    
    mutating func mapping(map: Map) {
        discountCode           <- map["discountCode"]
        state                  <- map["state"]
    }
    
}

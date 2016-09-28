//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

/**
    Provides set of interactions for querying, retrieving by UUID and by key for product types.
*/
open class ProductType: ByIdEndpoint, ByKeyEndpoint, QueryEndpoint, Mappable {
    
    public typealias ResponseType = ProductType

    open static let path = "product-types"
    
    // MARK: - Properties
    
    public required init?(map: Map) {}
    
    // MARK: - Mappable
    
    public func mapping(map: Map) {}

}

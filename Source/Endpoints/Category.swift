//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

/**
    Provides set of interactions for querying and retrieving by UUID for categories.
*/
open class Category: ByIdEndpoint, QueryEndpoint, Mappable {
    
    public typealias ResponseType = Category

    open static let path = "categories"
    
    // MARK: - Properties
    
    public required init?(map: Map) {}
    
    // MARK: - Mappable
    
    public func mapping(map: Map) {}

}

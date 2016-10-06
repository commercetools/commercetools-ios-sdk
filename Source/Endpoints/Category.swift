//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

/**
    Provides set of interactions for querying and retrieving by UUID for categories.
*/
open class Category: ByIdEndpoint, QueryEndpoint {
    
    public typealias ResponseType = NoMapping

    open static let path = "categories"
}

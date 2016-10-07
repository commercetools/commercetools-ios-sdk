//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

/**
    Provides complete set of interactions for querying, retrieving and creating an order.
*/
open class Order: QueryEndpoint, ByIdEndpoint, CreateEndpoint {
    
    public typealias ResponseType = NoMapping
    public typealias RequestDraft = NoMapping

    open static let path = "me/orders"
}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

/**
    Provides complete set of interactions for querying, retrieving and creating an order.
*/
open class Order: QueryEndpoint, ByIdEndpoint, CreateEndpoint {
    
    public typealias ResponseType = NoMapping

    open static let path = "me/orders"
}

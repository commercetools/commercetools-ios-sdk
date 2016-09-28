//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

/**
    Provides complete set of interactions for querying, retrieving and creating an order.
*/
open class Order: QueryEndpoint, ByIdEndpoint, CreateEndpoint, Mappable {
    
    public typealias ResponseType = Order

    open static let path = "me/orders"
    
    // MARK: - Properties
    
    public required init?(map: Map) {}
    
    // MARK: - Mappable
    
    public func mapping(map: Map) {}

}

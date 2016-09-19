//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    Provides complete set of interactions for querying, retrieving, creating and updating shopping cart.
*/
open class Cart: QueryEndpoint, ByIdEndpoint, CreateEndpoint, UpdateEndpoint, DeleteEndpoint {

    open static let path = "me/carts"

    /**
        Retrieves the cart with state Active which has the most recent lastModifiedAt.

        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func active(_ expansion: [String]? = nil, result: @escaping (Result<[String: AnyObject]>) -> Void) {
        return ActiveCart.get(expansion, result: result)
    }

}

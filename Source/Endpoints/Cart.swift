//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides complete set of interactions for querying, retrieving, creating and updating shopping cart.
*/
public class Cart: QueryEndpoint, ByIdEndpoint, CreateEndpoint, UpdateEndpoint {

    public static let path = "me/carts"

}
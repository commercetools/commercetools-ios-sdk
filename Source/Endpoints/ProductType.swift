//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides set of interactions for querying, retrieving by UUID and by key for product types.
*/
open class ProductType: ByIdEndpoint, ByKeyEndpoint, QueryEndpoint {

    open static let path = "product-types"

}

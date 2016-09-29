//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

/**
    Provides complete set of interactions for querying, retrieving, creating and updating shopping cart.
*/
open class Cart: QueryEndpoint, ByIdEndpoint, CreateEndpoint, UpdateEndpoint, DeleteEndpoint, Mappable {
    
    public typealias ResponseType = Cart

    open static let path = "me/carts"

    /**
     Retrieves the cart with state Active which has the most recent lastModifiedAt.
     
         - parameter expansion:                An optional array of expansion property names.
         - parameter dictionaryResult:         The code to be executed after processing the response, containing result
                                               in dictionary format in case of a success.
     */
    open static func active(expansion: [String]? = nil, dictionaryResult: @escaping (Result<[String: Any]>) -> Void) {
        return ActiveCart.get(expansion: expansion, dictionaryResult: dictionaryResult)
    }

    /**
     Retrieves the cart with state Active which has the most recent lastModifiedAt.
     
         - parameter expansion:                An optional array of expansion property names.
         - parameter result:                   The code to be executed after processing the response, providing model
                                               instance in case of a successful result.
     */
    open static func active(expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        return ActiveCart.get(expansion: expansion, result: result)
    }
    
    // MARK: - Properties
    
    var id: String?
    var version: UInt?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var lineItems: [LineItem]?
    var totalPrice: Money?
    var taxedPrice: TaxedPrice?
    var country: String?
    
    public required init?(map: Map) {}
    
    // MARK: - Mappable
    
    public func mapping(map: Map) {
        id               <- map["id"]
        version          <- map["version"]
        createdAt        <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt   <- (map["lastModifiedAt"], ISO8601DateTransform())
        lineItems        <- map["lineItems"]
        totalPrice       <- map["totalPrice"]
        taxedPrice       <- map["taxedPrice"]
        country          <- map["country"]
    }

}

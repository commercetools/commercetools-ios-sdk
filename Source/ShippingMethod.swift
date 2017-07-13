//
// Copyright (c) 2017 Commercetools. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

/**
    Provides set of interactions for querying and retrieving by UUID for shipping methods. Retrieving a shipping method
    for a cart, or a location is also provided.
*/
public struct ShippingMethod: ByIdEndpoint, QueryEndpoint, ImmutableMappable {

    public typealias ResponseType = ShippingMethod

    public static let path = "shipping-methods"

    // MARK: - Shipping method endpoint functionality

    /**
        Retrieves an array of `ShippingMethod`s available for a particular `Cart`.

        - parameter cart:                     The cart used to retrieve the `ShippingMethod`s.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func `for`(cart: Cart, result: @escaping (Result<ShippingMethods>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            Alamofire.request(path, parameters: ["cartId": cart.id], encoding: URLEncoding.default, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                handleResponse(response, result: result)
            })
        })
    }

    /**
        Retrieves an array of `ShippingMethod`s available for a particular location.

        - parameter country:                  A two-digit country code as per ISO 3166-1 alpha-2.
        - parameter state:                    Optional state value.
        - parameter country:                  Optional currency code compliant with ISO 4217.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func `for`(country: String, state: String? = nil, currency: String? = nil, result: @escaping (Result<ShippingMethods>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            var parameters = ["country": country]
            if let state = state {
                parameters["state"] = state
            }
            if let currency = currency {
                parameters["currency"] = currency
            }

            Alamofire.request(path, parameters: parameters, encoding: URLEncoding.default, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                handleResponse(response, result: result)
            })
        })
    }

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: String
    public let description: String?
    public let taxCategory: Reference<TaxCategory>
    public let zoneRates: [ZoneRate]
    public let isDefault: Bool

    // MARK: - Mappable

    public init(map: Map) throws {
        id               = try map.value("id")
        version          = try map.value("version")
        createdAt        = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt   = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        name             = try map.value("name")
        description      = try? map.value("description")
        taxCategory      = try map.value("taxCategory")
        zoneRates        = try map.value("zoneRates")
        isDefault        = try map.value("isDefault")
    }
}

public struct ShippingMethods: ArrayResponse {
    public typealias ArrayElement = ShippingMethod
}
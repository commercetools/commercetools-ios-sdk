//
// Copyright (c) 2017 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides set of interactions for querying and retrieving by UUID for shipping methods. Retrieving a shipping method
    for a cart, or a location is also provided.
*/
public struct ShippingMethod: ByIdEndpoint, ByKeyEndpoint, QueryEndpoint, Codable {

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
            let request = self.request(url: path, urlParameters: ["cartId": cart.id], headers: self.headers(token))

            perform(request: request) { (response: Result<ShippingMethods>) in
                result(response)
            }
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

            let request = self.request(url: path, urlParameters: parameters, headers: self.headers(token))

            perform(request: request) { (response: Result<ShippingMethods>) in
                result(response)
            }
        })
    }

    // MARK: - Properties

    public let id: String
    public let key: String?
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: String
    public let description: String?
    public let taxCategory: Reference<TaxCategory>
    public let zoneRates: [ZoneRate]
    public let isDefault: Bool
}

public struct ShippingMethods: ArrayResponse {
    public typealias ArrayElement = ShippingMethod
}


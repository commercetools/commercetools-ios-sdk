//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class ShippingMethodTests: XCTestCase {

    private class CreateShippingMethod: CreateEndpoint {
        typealias ResponseType = ShippingMethod
        typealias RequestDraft = NoMapping
        static let path = "shipping-methods"
    }

    private class CreateZone: CreateEndpoint {
        typealias ResponseType = Zone
        typealias RequestDraft = NoMapping
        static let path = "zones"
    }

    private class QueryTaxCategory: QueryEndpoint {
        typealias ResponseType = TaxCategory
        typealias RequestDraft = NoMapping
        static let path = "tax-categories"
    }

    override func setUp() {
        super.setUp()

        setupProjectManagementConfiguration()
        let semaphore = DispatchSemaphore(value: 0)
        AuthManager.sharedInstance.token { token, error in
            ShippingMethod.query(limit: 1) { result in
                if result.model!.count == 0 {
                    QueryTaxCategory.query(limit: 1) { taxCategoryResult in
                        CreateZone.create(["name": "Germany", "locations": [["country": "DE"]]]) { zoneResult in
                            CreateShippingMethod.create(["name": "test-shipping-method", "isDefault": true,
                                                         "zoneRates":[["zone": ["id": zoneResult.model!.id, "typeId": "zone"],
                                                                       "shippingRates": [["price": ["currencyCode": "EUR", "centAmount": 1000]]]],
                                                                      ["zone": ["id": zoneResult.model!.id, "typeId": "zone"],
                                                                       "shippingRates": [["price": ["currencyCode": "USD", "centAmount": 1100]]]]],
                                                         "taxCategory": ["id": taxCategoryResult.model!.results.first!.id,
                                                                         "typeId": "tax-category"]]) { result in
                                semaphore.signal()
                            }
                        }
                    }
                } else {
                    semaphore.signal()
                }
            }
        }
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)

        cleanPersistedTokens()
        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testQueryForShippingMethods() {
        let shippingMethodsExpectation = expectation(description: "shipping methods expectation")

        ShippingMethod.query(predicates: ["name=\"test-shipping-method\""], limit: 1) { result in
            XCTAssert(result.isSuccess)
            XCTAssertEqual(result.model?.results.first?.name, "test-shipping-method")
            shippingMethodsExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testShippingMethodsForCountry() {
        let shippingMethodsExpectation = expectation(description: "shipping methods expectation")

        ShippingMethod.for(country: "DE") { result in
            let methods = result.model
            XCTAssert(result.isSuccess)
            XCTAssert(methods?.first?.zoneRates.first?.shippingRates.filter({ $0.price.currencyCode == "EUR" }).first?.isMatching == true)
            XCTAssertEqual(methods?.filter({ $0.name == "test-shipping-method" }).count, 1)
            shippingMethodsExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testShippingMethodsForCart() {
        let shippingMethodsExpectation = expectation(description: "shipping methods expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        let cartDraft = CartDraft(currency: "EUR", shippingAddress: Address(country: "DE"))

        Cart.create(cartDraft, result: { result in
            if let cart = result.model {
                XCTAssert(result.isSuccess)
                ShippingMethod.for(cart: cart) { result in
                    let methods = result.model
                    XCTAssert(methods?.first?.zoneRates.first?.shippingRates.filter({ $0.price.currencyCode == "EUR" }).first?.isMatching == true)
                    XCTAssertEqual(methods?.filter({ $0.name == "test-shipping-method" }).count, 1)

                    shippingMethodsExpectation.fulfill()
                }
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }
}

//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class CartTests: XCTestCase {

    override func setUp() {
        super.setUp()

        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testRetrieveActiveCart() {
        let activeCartExpectation = expectation(description: "active cart expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        Cart.create(["currency": "EUR"], result: { result in
            if let response = result.json, let cartState = response["cartState"] as? String, let id = response["id"] as? String {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(cartState, "Active")
                Cart.active(result: { result in
                    if let response = result.json, let activeCartId = response["id"] as? String {
                        XCTAssert(result.isSuccess)
                        XCTAssertEqual(activeCartId, id)
                        activeCartExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCartCreation() {
        let cartCreationExpectation = expectation(description: "cart creation expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        retrieveSampleProduct { lineItemDraft in
            var cartDraft = CartDraft()
            cartDraft.currency = "EUR"
            cartDraft.lineItems = [lineItemDraft]

            Cart.create(cartDraft, result: { result in
                if let cart = result.model {
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(cart.cartState, .active)
                    cartCreationExpectation.fulfill()
                }
            })
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testOrderCreation() {
        let orderCreationExpectation = expectation(description: "draft creation expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        retrieveSampleProduct { lineItemDraft in
            var cartDraft = CartDraft()

            var address = Address()
            address.country = "DE"
            cartDraft.shippingAddress = address
            cartDraft.currency = "EUR"
            cartDraft.lineItems = [lineItemDraft]

            Cart.create(cartDraft, result: { result in
                if let cart = result.model, result.isSuccess {
                    var orderDraft = OrderDraft()
                    orderDraft.id = cart.id
                    orderDraft.version = cart.version
                    Order.create(orderDraft, result: { result in
                        if let order = result.model {
                            XCTAssert(result.isSuccess)
                            XCTAssertEqual(order.cart?.id, cart.id)
                            orderCreationExpectation.fulfill()
                        }
                    })
                }
            })
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateEndpointWithModelAction() {
        let updateExpectation = expectation(description: "update expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        var cartDraft = CartDraft()
        cartDraft.currency = "EUR"

        Cart.create(cartDraft, result: { result in
            if let cart = result.model, let id = cart.id, let version = cart.version, result.isSuccess {
                ProductProjection.query(limit:1, result: { result in
                    if let product = result.model?.results?.first, result.isSuccess {
                        var options = AddLineItemOptions()
                        options.productId = product.id
                        options.variantId = product.masterVariant?.id

                        let updateActions = UpdateActions<CartUpdateAction>(version: version, actions: [.addLineItem(options: options)])
                        Cart.update(id, actions: updateActions, result: { result in
                            if let cart = result.model {
                                XCTAssert(result.isSuccess)
                                XCTAssertEqual(cart.lineItems?.count, 1)
                                XCTAssertNotNil(cart.lineItems?.first?.productType?.id)
                                updateExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testTaxModeChangeToDisabled() {
        let cartTaxModeExpectation = expectation(description: "cart tax mode expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        retrieveSampleProduct { lineItemDraft in
            var cartDraft = CartDraft()
            cartDraft.currency = "EUR"
            cartDraft.lineItems = [lineItemDraft]
            cartDraft.taxMode = .external

            Cart.create(cartDraft, result: { result in
                if let cart = result.model, let id = cart.id, let version = cart.version {
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(cart.taxMode, .external)

                    var options = ChangeTaxModeOptions()
                    options.taxMode = .disabled

                    let updateActions = UpdateActions<CartUpdateAction>(version: version, actions: [.changeTaxMode(options: options)])
                    Cart.update(id, actions: updateActions, result: { result in
                        if let error = result.errors?.first as? CTError, case .generalError(let reason) = error {
                            XCTAssert(result.isFailure)
                            XCTAssertEqual(reason?.message, "Disabled tax mode is not allowed on my cart.")
                            cartTaxModeExpectation.fulfill()
                        }
                    })
                }
            })
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testTaxModeChange() {
        let cartTaxModeExpectation = expectation(description: "cart tax mode expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        retrieveSampleProduct { lineItemDraft in
            var cartDraft = CartDraft()
            cartDraft.currency = "EUR"
            cartDraft.lineItems = [lineItemDraft]
            cartDraft.taxMode = .external

            Cart.create(cartDraft, result: { result in
                if let cart = result.model, let id = cart.id, let version = cart.version {
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(cart.taxMode, .external)

                    var options = ChangeTaxModeOptions()
                    options.taxMode = .platform

                    let updateActions = UpdateActions<CartUpdateAction>(version: version, actions: [.changeTaxMode(options: options)])
                    Cart.update(id, actions: updateActions, result: { result in
                        if let cart = result.model {
                            XCTAssert(result.isSuccess)
                            XCTAssertEqual(cart.taxMode, .platform)
                            cartTaxModeExpectation.fulfill()
                        }
                    })
                }
            })
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    private func retrieveSampleProduct(_ completion: @escaping (LineItemDraft) -> Void) {
        ProductProjection.query(limit:1, result: { result in
            if let product = result.model?.results?.first, result.isSuccess {
                var lineItemDraft = LineItemDraft()
                lineItemDraft.productId = product.id
                lineItemDraft.variantId = product.masterVariant?.id
                lineItemDraft.quantity = 3
                completion(lineItemDraft)
            }
        })
    }

}

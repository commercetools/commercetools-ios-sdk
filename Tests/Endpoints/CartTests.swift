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

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        Cart.create(["currency": "EUR"], result: { result in
            if let response = result.json, let cartState = response["cartState"] as? String, let id = response["id"] as? String,
                    result.isSuccess && cartState == "Active" {
                Cart.active(result: { result in
                    if let response = result.json, let activeCartId = response["id"] as? String, activeCartId == id {
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

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        retrieveSampleProduct { lineItemDraft in
            var cartDraft = CartDraft()
            cartDraft.currency = "EUR"
            cartDraft.lineItems = [lineItemDraft]

            Cart.create(cartDraft, result: { result in
                if let cart = result.model, cart.cartState == .active && result.isSuccess {
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

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

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
                        if let order = result.model, result.isSuccess, order.cart?.id == cart.id {
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

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

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
                            if let cart = result.model, cart.lineItems?.count == 1 {
                                updateExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        })

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

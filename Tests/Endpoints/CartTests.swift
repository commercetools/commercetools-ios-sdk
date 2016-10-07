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

        ProductProjection.query(limit: 1, result: { result in
            if let response = result.json,
                    let results = response["results"] as? [[String: AnyObject]],
                    let productId = results.first?["id"] as? String, let masterVariant = results.first?["masterVariant"] as? [String: Any], let variantId = masterVariant["id"] as? Int,
                    result.isSuccess {
                var cartDraft = CartDraft()
                cartDraft.currency = "EUR"

                var lineItemDraft = LineItemDraft()
                lineItemDraft.productId = productId
                lineItemDraft.variantId = variantId
                lineItemDraft.quantity = 3
                cartDraft.lineItems = [lineItemDraft]

                Cart.create(cartDraft, result: { result in
                    if let cart = result.model, cart.cartState == .active && result.isSuccess {
                        cartCreationExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

}

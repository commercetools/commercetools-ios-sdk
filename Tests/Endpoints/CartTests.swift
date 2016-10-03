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

        Cart.create(["currency": "EUR"], dictionaryResult: { result in
            if let response = result.response, let cartState = response["cartState"] as? String, let id = response["id"] as? String,
                    result.isSuccess && cartState == "Active" {
                Cart.active(dictionaryResult: { result in
                    if let response = result.response, let activeCartId = response["id"] as? String, activeCartId == id {
                        activeCartExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

}

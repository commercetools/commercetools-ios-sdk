//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class CreateEndpointTests: XCTestCase {

    private class TestCart: CreateEndpoint {
        typealias ResponseType = Cart
        typealias RequestDraft = CartDraft
        static let path = "me/carts"
    }
    
    override func setUp() {
        super.setUp()

        setupTestConfiguration()
    }
    
    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testCreateEndpoint() {

        let createExpectation = expectation(description: "create expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.login(username: username, password: password, completionHandler: { _ in})

        TestCart.create(["currency": "EUR"], result: { result in
            if let response = result.json, let cartState = response["cartState"] as? String, let version = response["version"] as? Int,
                    result.isSuccess && cartState == "Active" && version == 1 {
                createExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCreateEndpointError() {

        let createExpectation = expectation(description: "create expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.login(username: username, password: password, completionHandler: { _ in})

        TestCart.create(["currency": "BAD"], result: { result in
            if let error = result.errors?.first as? CTError, result.statusCode == 400, case .invalidJsonInputError(let reason) = error,
                    reason.message == "Request body does not contain valid JSON." &&
                    reason.details == "currency: ISO 4217 code JSON String expected" {
                createExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }
    
}

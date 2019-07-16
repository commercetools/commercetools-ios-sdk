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

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        TestCart.create(["currency": "EUR"], result: { result in
            if let response = result.json, let cartState = response["cartState"] as? String,
               let version = response["version"] as? Int {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(cartState, "Active")
                XCTAssertEqual(version, 1)
                createExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCreateEndpointError() {

        let createExpectation = expectation(description: "create expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        TestCart.create(["currency": "BAD"], result: { result in
            if let error = result.errors?.first as? CTError, case .invalidJsonInputError(let reason) = error {
                XCTAssert(result.isFailure)
                XCTAssertEqual(result.statusCode, 400)
                XCTAssertEqual(reason.message, "Request body does not contain valid JSON.")
                XCTAssertEqual(reason.details, "currency: Currency 'BAD' not valid as ISO 4217 code.")
                createExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testExternalUserIdHeader() {

        let createdByHeaderExpectation = expectation(description: "created by header expectation")

        let externalUserId = UUID().uuidString
        AuthManager.sharedInstance.externalUserId = externalUserId

        TestCart.create(["currency": "EUR"], result: { result in
            if let cart = result.model {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(cart.createdBy!.externalUserId, externalUserId)
                XCTAssertEqual(cart.lastModifiedBy!.externalUserId, externalUserId)
                createdByHeaderExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }
}
